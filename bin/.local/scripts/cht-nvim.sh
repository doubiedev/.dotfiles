#!/bin/bash

# Directories to search for Lua configuration files
CONFIG_DIRS=("~/.config/nvim/lua/config" "~/.config/nvim/lua/plugins")

# Output header for the cheatsheet
echo -e "Source\tMode\tKeybinding\tCommand\tDescription"

grep_files() {
  local dir="$1"
  find "$dir" -type f -name "*.lua"
}

parse_keybindings() {
  local file="$1"
  local plugin=$(basename "$file")

  while IFS= read -r line; do
    if [[ $line =~ vim\.keymap\.set\("(.*?)",\s*"(.*?)",\s*(.*?)\) ]]; then
      local mode="${BASH_REMATCH[1]}"
      local key="${BASH_REMATCH[2]}"
      local command="${BASH_REMATCH[3]%%)*}" # Extract text up to the last enclosing bracket
      local description=""
      if [[ $line =~ --\s*(.*)$ ]]; then
        description="${BASH_REMATCH[1]}"
      fi

      # Output the parsed keybinding in tabular format
      echo -e "$plugin\t$mode\t$key\t$command\t$description"
    fi
  done < "$file"
}

# Main logic
for dir in "${CONFIG_DIRS[@]}"; do
  dir_expanded=$(eval echo "$dir")
  for file in $(grep_files "$dir_expanded"); do
    parse_keybindings "$file"
  done
done

