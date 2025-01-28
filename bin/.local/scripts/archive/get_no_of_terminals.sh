#!/bin/bash

terminal=$1

# get the user running the current x-session
username=$(who | grep $DISPLAY | head -1 | awk '{print $1}')
# get the pid of the terminal for the current user
userpid=$(pgrep -u $username $terminal)
# check what type the terminal is (multi pid/single pid)
npids="$(echo "$userpid" | wc -w)"
# in case of a single pid, count the children
if [ "$npids" -eq 1 ]; then
  # check if gnome-pty-helper runs (starts when multiple users are logged in)
  ptpid=$(pgrep gnome-pty-helpe)
  # get number of child- procs
  let "orig = $( pgrep -P $(pgrep -u $username $terminal) | wc -w )" 
  # if pty-helper runs, correct the number of child procs
  if [ -n "$ptpid" ] && [ -n "$userpid" ]; then
    let "n_terms = $orig-1"; else let "n_terms = $orig"
  fi
  # if no child procs run, n-terminals = n-counted pids (difference Mate <> Unity)
  if [ "$n_terms" -eq 0 ]; then echo $orig; else echo $n_terms; fi
# in case of multiple pids, count the pids
elif [ "$npids" -gt 1 ]; then echo $npids
fi

