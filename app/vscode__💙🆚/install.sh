#!/bin/bash


# 🥾: install extensions
# to update extensions:
# code --list-extensions > extensions.txt


## VS CODE
# code --install-extension
# code --new-window
# code --reuse-window

# exceedsystem.vscode-macros


cat extensions.txt | grep -v "^#" | xargs -L 1 -- code --install-extension $1

