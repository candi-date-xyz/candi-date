#!/bin/bash

# setup the dev/test/prod environment.


# set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o nounset    # Exposes unset variables, strict mode. 
trap "set +o nounset" EXIT  # restore nounset at exit, even in crash!

# 🤔 trial: 
umask 000



set -o xtrace


# mark variables which are modified or created for export
set -a 


# docker run -d -it --name azcli --mount type=bind,source="/c0de",target=/c0de 

# 🍰 https://stackoverflow.com/questions/192319/how-do-i-know-the-script-file-name-in-a-bash-script
# 🍰 https://www.shell-tips.com/bash/environment-variables/
# ------------- SCRIPT ------------- #
#echo
#echo "# arguments called with ---->  ${@}     "
#echo "# \$1 ---------------------->  $1       "
#echo "# \$2 ---------------------->  $2       "
#echo "# path to me --------------->  ${0}     "
#echo "# parent path -------------->  ${0%/*}  "
#echo "# my name ------------------>  ${0##*/} "
#echo
# ------------- CALLED ------------- #

#* 进口v2 🥾 ALWAYS load _b00t_ 

#  _b00t_ is *mostly* a bunch of shell aliases
source "./_b00t_.bashrc"



./_b00t_/bash.🔨/is_inside_docker.sh &> /dev/null
export PROBABLY_NOT_DOCKER=$( echo $? )  # 0 = success
log_📢_记录 "🐋 PROBABLY_NOT_DOCKER: $PROBABLY_NOT_DOCKER"
SUDO_CMD=""
if [ ! "$PROBABLY_NOT_DOCKER" ] ; then
  log_📢_记录 "🐋🚫, require sudo"
  SUDO_CMD="sudo"
fi
export SUDO_CMD


# we begin with rust. 


# TODO: test for cargo
if ! command -v gcc &> /dev/null
then
  log_📢_记录 "🥾🦀 installing build-essentials"
  sudo apt -y install build-essential software-properties-common
  # aptitude
fi


# SANITY: at this point rustup should be installed!
if ! command -v argc &> /dev/null
then 
  # 🤓 https://github.com/sigoden/argc
  log_📢_记录 "🥾🦀🪂 installing argc with rust:cargo"
  cargo install argc
fi

# Command 'batcat' not found, but can be installed with:
if ! command -v bat &> /dev/null
then
  # 🤓 https://github.com/sharkdp/bat
  log_📢_记录 "🥾🦀🪂 installing sharkdp/bat with rust:cargo"
  cargo install bat
fi

# Command 'ripgrep' not found, but can be installed with:
if ! command -v ripgrep &> /dev/null
then
  # 🤓 https://github.com/sharkdp/bat
  log_📢_记录 "🥾🦀🥗 installing ripgrep with rust:cargo"
  cargo install ripgrep
fi

# Command 'fdfind' not found, but can be installed with:
if ! command -v fdfind &> /dev/null
then
  # 🤓 https://github.com/sharkdp/fd#installation
  log_📢_记录 "🥾🦀🍏 installing sharkdp/fd with cargo"
  cargo install fd-find
fi

if ! command -v entr &> /dev/null 
then
  # 🤓 http://eradman.com/entrproject/
  log_📢_记录 "🥾🐧🍏 install entr (watch file for changes)"
  sudo apt -y install entr
fi

# 🐙 github 'gh' client
if ! command -v gh &> /dev/null
then
  # 🤓 https://cli.github.com/
  log_📢_记录 "🥾🐙 installing github 'gh' command"
  wget https://github.com/cli/cli/releases/download/v2.10.1/gh_2.10.1_linux_amd64.deb
  sudo dpkg -i gh_2.10.1_linux_amd64.deb
fi

# 🥾 commands
source ./_b00t_/bash.🔨/init.10级.🥾.b00t.sh  
source ./_b00t_/bash.🔨/init.20级.🐧.linux.sh

# moreutils
# chronic: runs a command quietly unless it fails
# combine: combine the lines in two files using boolean operations
# errno: look up errno names and descriptions
# ifdata: get network interface info without parsing ifconfig output
# ifne: run a program if the standard input is not empty
# isutf8: check if a file or standard input is utf-8
# lckdo: execute a program with a lock held
# mispipe: pipe two commands, returning the exit status of the first
# parallel: run multiple jobs at once
# pee: tee standard input to pipes
# sponge: soak up standard input and write to a file
# ts: timestamp standard input
# vidir: edit a directory in your text editor
# vipe: insert a text editor into a pipe
# zrun: automatically uncompress arguments to command

# starship
# cargo install starship --locked


# https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
source ./_b00t_/bash.🔨/init.22级.🐙.git.sh
source ./_b00t_/bash.🔨/init.30级.🐳.层.docker.sh

# probably not necessary (yet)
# source ./_b00t_/bash.🔨/init.40级.🦬.语.c++.sh
#init.32级.💠.层.hashicorp.sh
#init.34级.⚙️.层.k8.sh

source ./_b00t_/bash.🔨/init.40级.🦀语.rust.sh
source ./_b00t_/bash.🔨/init.41级.🐍.语.python.sh

source ./_b00t_/bash.🔨/init.42级.🚀.语.node.sh
source ./_b00t_/bash.🔨/init.42级.🦄.语.typescript.sh

## all sorts of fubar: 
# go is required for podman, runc to compile buildah
# source ./_b00t_/bash.🔨/init.44级.🏇.语.go.sh
# sudo apt install runc
# steps to compile buildah
#sudo apt-get -y install software-properties-common
#sudo add-apt-repository -y ppa:alexlarsson/flatpak
#sudo add-apt-repository -y ppa:gophers/archive
#sudo apt-add-repository -y ppa:projectatomic/ppa
#sudo apt-get -y -qq update
#sudo apt-get -y install bats btrfs-tools git libapparmor-dev libdevmapper-dev libglib2.0-dev libgpgme11-dev libseccomp-dev libselinux1-dev skopeo-containers go-md2man

# buildah


#source ./_b00t_/bash.🔨/init.43级.🥷.语.vue.sh
#init.44级.☕.语.java.sh
#init.44级.🪆.语.rust.sh
#init.50级.👾.云☁️.gcp.sh
#init.50级.🤖.云☁️.azure.sh
#init.50级.🥾.云☁️.local.sh
#init.50级.🦉.云☁️.aws.sh
#init.60级.🎙️💙.应用.vscode.sh
#init.65级.🎙️🦚.应用.x11.sh
#init.70级.☎️.msg.sh
#init.70级.🎬.video.sh
#init.70级.📱.mobile.sh
#init.70级.🕹️.gamesim.sh
#init.70级.🤑.ecommerce.sh
#init.70级.🥯.crypto.sh
#init.70级.🧄.vpn.sh
#init.70级.🧠.ai.sh
#init.80级.🐱‍💻.esp32.sh


#if [ "/usr/bin/docker" ] ; then 
#    echo "🐳 has d0cker! loading docker extensions"
#    source "$_B00T_C0DE_Path/docker.🐳/_bashrc.sh"
#
#    ## 😔 docker context? 
#    ## https://docs.docker.com/engine/context/working-with-contexts/
#    # export DOCKER_CONTEXT=default
#    # log_📢_记录 "🐳 CONTEXT: $DOCKER_CONTEXT"  
#    # docker context ls
#fi


exit;




# ☁️ cloud -cli's
function az_cli () {
    # local args=("$@")
    docker run --rm -it -v $HOME/.azure:/root/.azure -v $(pwd):/root mcr.microsoft.com/azure-cli:latest az $@
}
alias az="az_cli"
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias gcp="docker run --rm -ti --name gcloud-config google/cloud-sdk gcloud "




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


#############################
###
# 🍰 https://superuser.com/questions/427318/test-if-a-package-is-installed-in-apt
#if debInst "$1"; then
#    printf 'Why yes, the package %s _is_ installed!\n' "$1"
#else
#    printf 'I regret to inform you that the package %s is not currently installed.\n' "$1"
#fi
function debInst() {
    dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

if debInst "moreutils" ; then
    # only show moreutils once. 
    #if [ $( crudini_get "b00t" "has.moreutils" ) -eq "0" ] ; then 
        log_📢_记录 "👍 debian moreutils is installed!"
        # crudini_set "b00t" "has.moreutils" $(yyyymmdd)
    #fi 
else
    log_📢_记录  "😲 install moreutils (required)"
    $SUDO_CMD apt-get install -y moreutils fzf
fi







# TODO
#https://github.com/AntJanus/programmers-proverbs





# verify docker has buildx
# docker buildx version
# github.com/docker/buildx v0.5.1-docker 11057da37336192bfc57d81e02359ba7ba848e4a

#if [ -z "$AZURE_TENANT_ID" ] ; then 
#  azure 
#  read -p '🤖 Azure TENANT_ID: ' AZURE_TENANT_ID
#fi 
# 7e8f7eda-7eff-483f-a415-77241728783b


#AZ_RESOURCE_ID= 
#select character in Sheldon Leonard Penny Howard Raj
#do
#    echo "Selected character: $character"
#    echo "Selected number: $REPLY"
#done

#this will setup your local instance with boot.
#if [ 0 ] ; then 
#motd
#echo "then something like this ... "
#echo "
#Project: $project
#
#type of environment
#  😁 welcome: new user / tutorial
#  🌌 config:  config a project
#  ☠️ deploy: deploy a project #
#
#"
#fi

## enable extra repos (for stuff like ffmpeg)
## https://linuxconfig.org/how-to-enable-disable-universe-multiverse-and-restricted-repository-on-ubuntu-20-04-lts-focal-fossa
# 
# - canonical "main" is free/open-source
# - universe is community maintained, free/open
sudo add-apt-repository universe
# - multiverse is restricted by copyright or legal issues
# sudo add-apt-repository multiverse
# - restricted is proprietary device drivers. 
# sudo add-apt-repository restricted


## list all init-files (excluding template) in the bash bash.🔨/
for bashrc in `/usr/bin/fdfind --type x --glob "init*.sh"  $_B00T_C0DE_Path/bash.🔨/ | sort` ; 
  do  
  echo $bashrc ; 
  bash_source_加载 $bashrc
done


## 进口 (Jìnkǒu :: Import/Load PHASE 1 * \\ 
# _b00t_ Bin shell & helpers, logging. 
# bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.10*.🥾.*.sh"


## 进口 (Jìnkǒu :: Import/Load) PHASE 2 * * \\ 
# Two is Torvalds Tech (Linux & Git)
#bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🐧.*.sh"
#bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🐙.*.sh"

# Also, Docker
#bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🐳.*.sh"

## 进口 (Jìnkǒu :: Import/Load) PHASE 3 * * * \\ 
## minimal c0re Python 🐍
# + establish .venv
bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🐍.*sh"
source .venv/bin/activate

## Typescript & Node
# bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🚀.*.sh"
# Future: 
# bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🦄.*.sh"

## 进口 (Jìnkǒu :: Import/Load) PHASE 4 * * * * \\ 
#bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🤖.*.sh"
#bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.👾.*.sh"

# AWS, etc. 
# bash_source_加载 "$_B00T_C0DE_Path/./bash/c0re_init.*.🦉.sh"

## 进口 * * * // 


##* * * * \\
# 目录 (Mùlù) Directory
#if [ -d "$c0dePath/./pr0j3cts/./$project_dir" ] ; then
#    export PROJECT_dirExist=`$c0dePath/./pr0j3cts/./$project_dir`
#    echo "🥾 the $c0dePath/./pr0j3cts/./$project_dir already exists use --force"
#else
#    export PROJECT_dirExists=""
#fi
#mkdir -p "$c0dePath/./pr0j3cts/./$project"
##* * * * // 

#*  🐳 docker setup.

# TODO: link to the Elasticdotventures repository
# 
#docker build -t cowsay .
# 🐳♻️ It’s a good habit to use --rm to avoid filling up your system with stale Docker containers.
#docker run --rm cowsay 

#sh >out <<EOF
#🐛 If you didn't get a cowsay, let me know. 
#
#🤓 at this point you can start to build using EV _b00t_ or 
#your own _b00t_.  

#type:
#git clone https://github.com/elasticdotventures/_b00t_/generate

#EOF

#echo "* if you just saw a talking cow, everything is fine!"
#echo "run ./02_t00ls_.sh"


