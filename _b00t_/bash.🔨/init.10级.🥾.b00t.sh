
set -o xtrace

if [ -z "$_B00T_C0DE_Path" ] ; then 
    _B00T_C0DE_Path="./."
fi
source "$_B00T_C0DE_Path/_b00t_.bashrc"


## * * * *// 
#* Purpose: imports standard bash behaviors
#*          for consistent handling of parameters
#*
## * * * *//
set +euxo pipefail
if [ -v $SUDO_CMD ] ; then
    SUDO_CMD="sudo"
fi

set -euxo pipefail


$SUDO_CMD apt-get upgrade -y && $SUDO_CMD apt-get -y update

# apt-transport-https is for google/k8, others. 
$SUDO_CMD apt-get -y install build-essential procps curl file git apt-transport-https ca-certificates 

# Boot functions
ARCH="$(uname -m | cut -b 1-6)"

# moved to _b00t_.bashrc
# source "$_B00T_C0DE_Path/./bash.🔨/.bash_aliases"


function checkOS() {
    IS_supported=`cat /etc/os-release | grep "Ubuntu 20.04.2 LTS"`
    if [ -z "$IS_supported" ] ; then
        cat /etc/os-release
        log_📢_记录 "👽不支持  OS not yet supported." && exit 0
        return 1
    else
        log_📢_记录 "👍 OS is supported"
    fi

    return 0 
}
checkOS_result="$(checkOS)"
#echo "checkOS_result: $checkOS_result"


#func(){
#    echo "Username: $USER"
#    echo "    EUID: $EUID"
#}
# 🤓 "Exporting" export -f creates an env variable with the function body.
# export -f func

##* * * * * *\\
if [ "$EUID" -ne 0 ]
  then echo "👽 Please run as root, use sudo or enter root password" 
  # su "$SUDO_USER" -c 'func'
fi
##* * * * * *//

## 命令 \\
# Mìnglìng // Command   (mkdir)
function mkdir_命令() {
    args=("$@")
    dir=${args[0]}
    #dir=$1
    cmd="/bin/mkdir -p \"$dir\""
    result=$( "$cmd" )
    echo "🚀 $cmd"
    
    if [ ! -d "$dir" ] ; then 
        log_📢_记录 "👽:不支持 failed. probably requires permission!" 

        log_📢_记录 "😇.run: sudo $cmd"
        `/usr/bin/sudo $cmd`
        if [ ! -d "$dir" ] ; then 
            log_📢_记录 "👽:不支持 sudo didn't work either."
        fi
    fi
    }



#export mkdir_命令
#mkdir_命令 "$HOME/.b00t_"
#mkdir_命令 "$HOME/.b00t_/c0re"
#chmod 711 "$HOME/._00t_/c0re"
## 命令 // 


if n0ta_xfile_📁_好不好 webi ; then
    # webi is a super easy package installer
    log_📢_记录 "🥾🕸️ install webi the web installer - (http://webinstall.dev)"
    curl -sS https://webinstall.dev/webi | bash
fi


# webi offers an alternative (but not cross platform i think)
if n0ta_xfile_📁_好不好 "~/.local/bin/dotenv" ; then
    # TODO: wtf - not https://github.com/bashup/dotenv? 
    # TODO: chezmoi - https://github.com/twpayne/chezmoi
    log_📢_记录 "🕸️.webi dotenv"
    webi dotenv@stable
fi


##* * * * * *\\
# Install Some Tooling
# 🍰 fzf - menu, file choose  https://github.com/junegunn/fzf#using-git
# 🍰 jq  - JSON config i/o    https://stedolan.github.io/jq/
# 🍰 wget- HTTP i/o 
# 🍰 curl- HTTP i/o 

if  [ ! command -v "/bin/sed" &> /dev/null ] || \
     [ ! command -v "/usr/bin/fzf" &> /dev/null ] || \
     [ ! command -v "/usr/bin/jq" &> /dev/null ] || \
     [ ! command -v "/usr/bin/wget" &> /dev/null ]  ; then
    $SUDO_CMD apt-get install -y sed fzf jq wget curl
    # curl -sS https://webinstall.dev/jq | bash
    # 
fi


# https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
## not presently using whiptail. 
#if n0ta_xfile_📁_好不好 "/usr/bin/whiptail" ; then 
#    # whiptail makes interactive menus
#    # 🤓 https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail
#    log_📢_记录 "😇.install whiptail menus"
#    $SUDO_CMD apt-get install -y whiptail
#fi


##### 
## after a lot of moving around, it's clear 
## yq4 needs to be here, since it's used in a variety of menus
## for d1rd1ct (next)
installYQ=false
YQ4_VERSION="v4.8.0"
YQ4_BINARY="yq_linux_amd64"  # TODO: multiarch 
YQ4_MIN_VERSION="4.0.0"
YQ4_INSTALL_PATH="/usr/local/bin/yq4"

if n0ta_xfile_📁_好不好 "$YQ4_INSTALL_PATH" ; then
    log_📢_记录 "😲 yq4 does not appear to be installed, f1x1ng."
    # missing yq
    installYQ=true
else 
    # check yq version 
    log_📢_记录 "🧐 checking yq4"
    currentYQver="$(yq4 -V | cut -f 2 -d ' ')"
    isYQokay=$(is_v3rs10n_大于 "$YQ4_MIN_VERSION" $currentYQver)
    if [ ! "$isYQokay" = false ] ; then
        # TODO: consent
        log_📢_记录 "👻👼 insufficient yq --version, f1x1ng."
        installYQ=true
        # $SUDO_CMD snap remove yq
        # $SUDO_CMD apt-get remove yq
        $SUDO_CMD rm -f /usr/bin/yq4 
        $SUDO_CMD rm -f /usr/local/bin/yq4
        $SUDO_CMD rm -f ~/.local/bin/yq4
    fi
fi

# there are TWO YQ's !!! fuck this. 
# https://github.com/kislyuk/yq




# 🍰 yq  - YAML config i/o    https://github.com/mikefarah/yq
# not using yq via snap.  way too old!! 
#if n0ta_xfile_📁_好不好 "/usr/bin/yq" ; then
#    systemctl status snapd.service
#    snap install yq
#fi
if [ "$installYQ" = true ] ; then 
    log_📢_记录 "🐧😇 upgrading $YQ4_INSTALL_PATH"
    tmpdir=$(mktemp -d)
    pwdwas=`pwd`
    cd $tmpdir && \
     wget https://github.com/mikefarah/yq/releases/download/${YQ4_VERSION}/${YQ4_BINARY}.tar.gz -O - |\
     tar xz && $SUDO_CMD cp ${YQ4_BINARY} "$YQ4_INSTALL_PATH" && \
     rm -f $YQ4_BINARY
    cd $pwdwas
    
    currentYQver="$(yq4 -V | cut -f 2 -d ' ')"
    isYQokay=$(is_v3rs10n_大于 "$YQ4_MIN_VERSION" $currentYQver)
    if n0ta_xfile_📁_好不好 "$YQ4_INSTALL_PATH" ; then
        log_📢_记录 "💩 STILL missing $YQ4_INSTALL_PATH (required for d1ctd1r)"
        exit
    elif [ "$isYQokay" = true ] ; then
        log_📢_记录 "😇🎉 yq4 installed"
    else
        log_📢_记录 "💩🍒 yq4 installed, but version still insufficient (wtf)"
    fi 
fi



log_📢_记录 "🥾😇.install dialog & apt-utils"
$SUDO_CMD apt-get install -y dialog apt-utils

# _b00t_ cli - "/usr/local/bin/b00t"

## 
#if [ ! -f "~./b00t" ] ; then
#    $SUDO_CMD ln -s /c0de/_b00t_/up-cli.sh /usr/local/bin/b00t
#fi

##* * * * * *//

PATHMAN_EXISTS=$(whereis -b pathman | cut -f 2 -d ':')
if [ -z "$PATHMAN_EXISTS " ] ; then
    log_📢_记录 "😇 install pathman"
    curl -sS https://webinstall.dev/pathman | bash
fi
pathman add ~/.local/bin

$SUDO_CMD apt install uni2ascii 

set +euxo pipefail
