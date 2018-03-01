## proxychains Plugin for Fish Shell

### About

A Fish plugin to enter proxychains command with a shortcut. Ideas taken from sudope fish plugin.

### Install

Copy fish-chains folder into **~/.local/share/omf/pkg/**

### Usage

Press `Ctrl`+`s` to activate it.
It will add `proxychains -q ` to the beginning of the line if missing, remove it if it is present while preserving the cursor position.
If the current line is empty, it will do the same thing to the most recent history item.
