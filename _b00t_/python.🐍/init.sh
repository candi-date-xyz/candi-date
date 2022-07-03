#!/bin/bash



# TODO: test for pipx
# 
if [ -n "$(whereis register-python-argcomplete3)" ] ; then 
    echo "🦨++ installing python3-argcomplete + pipx"
    sudo apt install python3-argcomplete pipx -y
fi 
if [ -n "$(whereis register-python-argcomplete3)" ] ; then 
    eval "$(register-python-argcomplete3 pipx)"
    # pipx run
fi 
#sudo add-apt-repository ppa:deadsnakes/ppa
#sudo apt-get install python3.10

# pipx install python


# FUTURE: almost ready to start install requirements, for python

source "./_b00t_.bashrc"

txtFiles=( `/usr/bin/fdfind --color=always -t f '\.txt$'` )
for file in ${txtFiles[@]}; do
    #if [ gr]
    # echo "f: $file"
    # https://www.linuxjournal.com/content/pattern-matching-bash
    isStage=$(echo \"$file\" | grep -c ".层_")

    pipIt=false
    if [ "$isStage" -eq 1 ] ; then 
        # stage file handler
        pipIt=true
    elif [ $(basename "$file") == "requirements.txt" ]; then 
        # is a requirements file
        pipIt=true
    fi

    if [ $pipIt = true ]; then 
        echo "pipIt! $file"
        pip3 install -r $file
    fi
done

# install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
