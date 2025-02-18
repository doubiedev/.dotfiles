#!/usr/bin/env bash
languages=`echo "golang lua" | tr ' ' '\n'`
core_utils=`echo "vim nvim tmux xargs find mv sed awk grep" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf $languages | grep -qs $selected; then
    tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
else
    curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done
fi
