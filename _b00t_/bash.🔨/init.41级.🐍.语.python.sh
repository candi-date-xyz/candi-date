
#* 进口v2 🥾 ALWAYS load c0re Libraries!
#source "./_b00t_.bashrc"

if [ -v $SUDO_CMD ] ; then
    SUDO_CMD="sudo"
fi

if [ -z "$_B00T_C0DE_Path" ] ; then 
    _B00T_C0DE_Path="./."
fi
source "$_B00T_C0DE_Path/_b00t_.bashrc"


set -euxo pipefail

## * * * *// 
#* 🐍Purpose: b00tstraps python, so we can start using libraries
#* should be called directly from ./01-start.sh 
## * * * *\\

# Pip requires: 
$SUDO_CMD apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip

# install pipx as a user package outside the vent
python3 -m pip install --user pipx

# Python init. 
$SUDO_CMD apt install -y python3-venv

# Establish virtual environemnt
python3 -m venv .venv
source .venv/bin/activate

## PipX 
## Install and Run Python Applications in Isolated Environments
## https://github.com/pypa/pipx
# python3 -m pip install --user pipx

python3 -m pipx ensurepath
pipx completions
## we will install/uninstall _b00t_ packages via pipx
pipx install 

# Package Management
## Poetry
## https://python-poetry.org/docs/
# curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -


# TODO: verify tests can be run!
# TESTING: 
# https://github.com/se2p/pynguin





