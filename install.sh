#!/bin/bash

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
source "./_b00t_.bashrc"

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
#bash_source_加载 "$_B00T_C0DE_Path/./bash.🔨/init.*.🐍.*sh"
#source .venv/bin/activate

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


