#!/bin/sh

if ! command -v rustup &> /dev/null
then
  echo "🥾🦀 installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
fi

if ! command -v argc &> /dev/null
then
    # argc is a minimal replacement for bash getopts
    cargo install argc
fi


