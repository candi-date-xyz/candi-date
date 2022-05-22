#!/bin/sh

if ! command -v rustup &> /dev/null
then
  log_📢_记录 "🥾🦀 installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
fi

if ! command -v argc &> /dev/null
then
    # argc is a minimal replacement for getops
    cargo install argc
fi


