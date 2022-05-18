#!/bin/bash

# set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o nounset    # Exposes unset variables, strict mode. 
trap "set +o nounset" EXIT  # restore nounset at exit, even in crash!

# 🤔 trial: 
umask 000


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

#* 进口v2 🥾 ALWAYS load c0re Libraries!


#  _b00t_ is *mostly* a bunch of shell aliases
source "./_b00t_.bashrc"

# we begin with rust. 

if ! command -v rustup &> /dev/null
then
  log_📢_记录 "🥾🦀 installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
fi

# TODO: test for cargo
if ! command -v gcc &> /dev/null
then
  log_📢_记录 "🥾🦀 installing build-essentials"
  sudo apt -y install build-essential
  sudo apt -y install software-properties-common
fi


# SANITY: at this point rustup should be installed!
if ! command -v argc &> /dev/null
then 
  log_📢_记录 "🥾🦀🪂 installing argc with rust:cargo"
  cargo install argc
fi

# Command 'batcat' not found, but can be installed with:
if ! command -v bat &> /dev/null
then
  # 🤓 https://github.com/sharkdp/bat
  log_📢_记录 "🥾🦀🪂 installing argc with rust:cargo"
  cargo install bat
fi

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

exit;

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
    $SUDO_CMD apt-get install -y moreutils
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


