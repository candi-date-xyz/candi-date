#
# Purpose: universal bash b00t-strap for environment & tooling
#   once run in an enviroment will attempt to validate & construct
#   bash shortcuts, menus, etc. 
#


if ! command -v argc &> /dev/null
then
    # argc is a rust alternative to bash getopt
    # it is auto-installed later
    # 🤓 https://github.com/sigoden/argc/blob/main/examples/demo.sh
    eval "$(argc $0 "$@")"
fi


# usage:
#   source "./_b00t_.bashrc"
#   may also *eventually* run via commandline. 

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
# https://github.com/awesome-lists/awesome-bash

# set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o nounset    # Exposes unset variables, strict mode. 
trap "set +o nounset" EXIT  # restore nounset at exit, even in crash!

# 🤔 trial: 
umask 000


# mark variables which are modified or created for export
set -a 


## 小路 \\
## Xiǎolù :: Path or Directory
# THINGS YOU CAN EDIT: 
_B00T_C0DE_Path="./_b00t_"
if [ -d "$_B00T_C0DE_Path" ] ; then
    echo "😁 found $_B00T_C0DE_Path"
else 
    echo "😖 missed $_B00T_C0DE_Path"
fi

if [ -d "$HOME/._b00t_" ] ; then 
    _B00T_C0DE_Path="$HOME/._b00t_"
fi 
# maybe setup a ~/._b00t_ to ./_b00t_

export _B00T_C0DE_Path
export _B00T_C0NFIG_Path="$HOME/._b00t_"
## 小路 //





## 记录 \\
## Jìlù :: Record (Log)
# 🤓 write to a log if you want using >> 
# mostly, this is for future opentelemetry & storytime log
unset -f log_📢_记录
function log_📢_记录() {
    echo "$@"
}
export -f log_📢_记录
## 记录 //

## this will allow b00t to restart itself. 
unset -f reb00t
function reb00t() {
    unset -f _b00t_init_🥾_开始
    log_📢_记录 "🥾 restarting b00t"
    source "$_B00T_C0DE_Path/_b00t_.bashrc"
}




## * * * * * \\
## pathAdd 
unset pathAdd: adds a string to the path
function pathAdd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
# webi tools
pathAdd "$HOME/.local/bin"
pathAdd "$HOME/.yarn/bin"
## * * * * * //


## * * * * * \\
## is_version_大于
## compared #.#.# version (but could detect other formats)
## usage: is_version_大于 $requiredver $currentver
unset -f is_v3rs10n_大于
function is_v3rs10n_大于()   # $appversion $requiredversion
{
    # echo "hello $1 $2"
    # printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
    local appver=$1     # i.e. 1.0.0
    local requiredver=$2 # i.e. 1.0.1
    if [ "$(printf '%s\n' "$requiredver" "$appver" | sort -V | head -n1)" = "$requiredver" ]; then 
        # version is insufficient
        result="false"
    else
        # version is sufficient (大于 greater than equal)
        result="true"
    fi

    echo $result
    return 0
}
export -f is_v3rs10n_大于
## * * * * * * //


## 
# does a bash/function exist?
# 🍰 https://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
# returns: 
#     0 on yes/success (function defined/available)
#     1 for no (not available)
function has_fn_✅_存在() {
    local exists=$(LC_ALL=C type -t $1)
    # echo "exists: $exists"
    if [ -n "$exists" ] ; then 
        # exists, not empty, success
        return 0 
    fi 
    # fail (function does not exist)
    return 1
    # result=[[ -n "$exists" ]] || 1 
}
export -f has_fn_✅_存在




## All the logic below figures out who is calling & hot-reload
## bail earlier is better, 
_b00t_exists=`type -t "_b00t_init_🥾_开始"`
_b00t_VERSION_was=0
if [ "$_b00t_exists" == "function" ] ; then 
    # are we re-entry, i.e. reb00t
    export _b00t_VERSION_was="$_b00t_VERSION"
fi
# -------------- CONFIGURABLE SETTING -----------------
export _b00t_VERSION="1.0.15"
# -----------------------------------------------------

# syntax: current required
# echo "v3r: $_b00t_VERSION "
upgradeB00T=$(is_v3rs10n_大于 "$_b00t_VERSION_was" "$_b00t_VERSION")
# echo "upgradeB00T: $upgradeB00T"

# 🦨 need consent!
if [ "$upgradeB00T" ==  true ] && [ -n "$_b00t_VERSION_was" ] ; then 
    # welcome! (clean environment)
    log_📢_记录 "🥾🧐 b00t version | now: $_b00t_VERSION"
elif [ "$upgradeB00T" ==  true ] ; then 
    ## upgrade b00t in memory (this doesn't work awesome, but useful during dev)
    ## $ reb00t
    log_📢_记录 "🥾🧐 (re)b00t version | now: $_b00t_VERSION | was: $_b00t_VERSION_was | upgrade: $upgradeB00T"
    # TODO: consent
elif [ "$_b00t_exists" == "function" ] ; then 
    # SILENT, don't reload unless _b00t_VERSION is newer
    # short circuit using rand0() function 
    # log_📢_记录 "👻 short-circuit"
    set +o nounset 
    return
    ## 🍒 short circuit! 
fi

## Have FZF use fdfind "fd" by default
export PS_FORMAT="pid,ppid,user,pri,ni,vsz,rss,pcpu,pmem,tty,stat,args"
export FD_OPTIONS="--follow -exlude .git --exclude node_modules"

## OPINIONATED ALIASES



alias ls='ls -F  --color=auto'
# pretty = ll
#-rw-rw-r-- 1 1000 1000  100 May  5 23:51 requirements.txt
#-rw-rw-r-- 1 1000 1000  144 May  5 20:01 requirements.层_b00t_.txt
#-rw-rw-r-- 1 1000 1000  221 Apr 25 20:27 requirements.层_c0re.txt
alias ll='ls -lh'

#4.0K src/
#4.0K requirements.层_test.txt
#4.0K requirements.层_c0re.txt
alias lt='ls --human-readable --size -1 -S --classify'


alias s=ssh
alias c=clear
alias cx='chmod +x'
alias myp='ps -fjH -u $USER'

#mcd() { mkdir -p $1; cd $1 }
#export -f mcd
#cdl() { cd $1; ls}
#export -f cdl



# bat - a pretty replacement for cat.
alias batOrCat="/bin/cat"
if ! command -v bat &> /dev/null 
then
    alias batOrCat=$(command -v bat)
fi


# bats - bash testing system (in a docker container)
# 🦨 need consent before running docker
# 🦨 this is not the proper way to run bats. 
# alias bats='docker run -it -v bats/bats:latest'

# count the files in a directory or project
alias count='find . -type f | wc -l'
# copy verbose, see rsync. or use preferred backup command. 
alias cpv='rsync -ah --info=progress2'

# cd to _b00t_ (or current repo)
alias cg='cd `git rev-parse --show-toplevel`'
alias ..='cd ..'
alias ...='cd ../../'
alias mkdir='mkdir -pv'

# time & date
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# 🐙 git 
alias gitstatus='git -C . status --porcelain | grep "^.\w"'

# 🐍 Python ve = create .venv, va = activate!
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# use fzf to find a file and open it in vs code
alias c='code $(fzf --height 40% --reverse)'

# fd is same-same like unix find, but alt-featureset
# for example - fd respects .gitignore (but output like find)
if ! command -v fdfind &> /dev/null ; then
    alias fd="/usr/bin/fdfind"
fi

# handy for generating dumps, etc..
# $ script.sh >> foobar.`ymd`
alias yyyymmdd="date +'%Y%m%d'"
alias ymd="date +'%Y%m%d'"
alias ymd_hm="date +'%Y%m%d.%H%M'"
alias ymd_hms="date +'%Y%m%d.%H%M%S'"
##################

## 鲸 \\
# Jīng :: Whale
if ! command -v docker &> /dev/null 
then
    log_📢_记录 "🥾🐳 whoa, real docker, not tested/supported"
    exit 1
else if [ command -v docker &> /dev/null ] ; 
then
    log_📢_记录 "🥾🐳 aliased docker to podman"
    alias docker="podman"
fi 





## 进口 \\  
## Kāishǐ :: Start
# init should be run by every program. 
# this is mostly here for StoryTime and future hooks. 
unset -f _b00t_init_🥾_开始
function _b00t_init_🥾_开始() {
    local args=("$@")
    local param=${args[0]}

#    if [ param="version" ] ; then
#        echo "🥾v: $currentB00TVersion"
#    fi 
    
    # earlier versions, sunset: 
    #🌆 ${0}/./${0*/}"   
    #🌆 export _b00t_="$(basename $0)"
    export _b00t_="$0" 

    if [ $_b00t_ == "/c0de/_b00t_/_b00t_.bashrc" ] ; then
        log_📢_记录 ""
        log_📢_记录 "usage: source /c0de/_b00t_/_b00t_.bashrc"
        exit 
    fi

    local PARENT_COMMAND_STR="👽env-notdetected"
    if [ $PPID -eq 0 ] ; then
        if [ "$container" == "docker" ] ; then
            PARENT_COMMAND_STR="🐳 d0ck3r!"
        
        else 
            PARENT_COMMAND_STR="👽env-unknown"
        fi
    else 
        # lookup parent application by process id. 
        PARENT_COMMAND_STR=$(ps -o comm=$PPID)
    fi

    if [ "$PARENT_COMMAND_STR" == "bash" ] ; then
        # most common case can be summarized
        log_📢_记录 "🥾👵:🔨"
    else 
        log_📢_记录 "🥾👵 from: $PARENT_COMMAND_STR"
    fi


    log_📢_记录 "🥾 -V: $_b00t_VERSION  init: $_b00t_"
    if [ -n "${@}" ] ; then 
        log_📢_记录 "🥾 args: ${@}"  
    fi 
}
export -f _b00t_init_🥾_开始
#_b00t_init_🥾_开始

## 进口 //


# alpine container support
# https://github.com/ethereum/solidity/issues/875
# returns 0 for "true" (not alpine linux), non-zero for false (is alpine linux)
function iz_n0t_alpine_linux_🐧🌲() {
   return $(cat /etc/os-release | grep "NAME=" | grep -ic "Alpine")
}
if [ ! iz_n0t_alpine_linux ] ; then
    # gh issue 
    echo "🥾🤮 🐧🌲 alpine linux not fully supported yet"
fi 


# this is intended to catch & report errors
function barf_🤮 () {
    gh issue create
    # gh issue create --title $1
}



# Webi, presently breaks alpine config! 
# https://github.com/elasticdotventures/webi-installers
webi=$(whereis webi)
if [ -z "$webi" ] ; then 
    curl https://webinstall.dev/webi | bash
    # Should install to $HOME/.local/opt/<package>-<version> or $HOME/.local/bin
    # Should install to $HOME/.local/opt/<package>-<version> or $HOME/.local/bin
    # Should not need sudo (except perhaps for a one-time setcap, etc) 
fi 


#
# Returns seconds until a relative time i.e. "today 4pm"
#
function secondsUntil () {
    # pass "today 5:25pm"
    # same "today 17:25"
    # .. "tomorrow"
    WHEN=$1
    echo $(( $(date +%s -d "$WHEN") - $( date +%s ) ))
}


## 加载 * * * * * *\\
## Jiāzài :: Load
unset -f bash_source_加载
function bash_source_加载() {
    local file=$1

    log_📢_记录 "."
    log_📢_记录 "."

    # Bash Shell Parameter Expansion:
    # 🤓 https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
    # The ‘$’ character introduces parameter expansion, command substitution, or arithmetic expansion. 
    # {} are optional, but protect enclosed variable
    # when {} are used, the matching ending brace is the first ‘}’ not escaped by a backslash or within a quoted string, and not within an embedded arithmetic expansion, command substitution, or parameter expansion.
    # 🍰 https://www.xaprb.com/media/2007/03/bash-parameter-expansion-cheatsheet.pdf
    
    function expand { for arg in "$@"; do [[ -f $arg ]] && echo $arg; done }

    if [ ! -x "$file" ] ; then
        # .bashrc file doesn't exist, so let's try to find it. 
        # trythis="${trythis:-$file}"        
        # trythis=$file
        # ${trythis:-$file}
        # 
        log_📢_记录 "🧐 expand $file"
        file=$( expand $file )
        
        if [ -x "$file" ] ; then
            log_📢_记录 "🧐 using $file"
        else 
            log_📢_记录 "😲 NOT EXECUTABLE $file"
        fi

    fi

    if [ ! -x "$file" ] ; then
        log_📢_记录 "🗄️🔃😲🍒 NOT EXECUTABLE: $file" && exit 
    else
        log_📢_记录 "🗄️🔃😏  START: $file"
        source "$file" 
        if [ $? -gt 0 ] ; then
            echo "☹️🛑🛑🛑 ERROR: $file had runtime error! 🛑🛑🛑"
        fi
        log_📢_记录 "🗄️🔚😁 FINISH: $file"
    fi

    return $?
}
export -f bash_source_加载



## 好不好 \\
## Hǎo bù hǎo :: Good / Not Good 
## is_file readable? 
# n0t_file_📁_好不好 result: 
#   0 : file is okay
#   1 : file is NOT okay
## if passed two or more files, will try all.
function n0ta_xfile_📁_好不好() {
    local args=("$@")
    xfile=${args[0]}
    if [ $# -gt 1 ] ; then
        # more than one file. try many
        while [ ! -x "$xfile" ] && [ "$#" -gt 1 ] ; do 
            shift
            xfile=$1
        done
    fi 
    
    if [ ! -f "$xfile" ] ; then
        log_📢_记录 "👽:不支持 $xfile is both required AND missing. 👽:非常要!"
        return 0
    elif [ ! -x "$xfile" ] ; then
        log_📢_记录 "👽:不支持 $xfile is not executable. 👽:非常要!"
        return 0
    else

        if ! has_fn_✅_存在 "crudini_get" ; then 
            :   # crudini_get doesn't exist.
        elif [[ $( crudini_get "b00t" "has.$xfile" ) = "" ]] ; then 
            log_📢_记录 "👍 $xfile"
            crudini_set "b00t" "has.$xfile" $( yyyymmdd )
        fi
        return 1
    fi
}
## 好不好 // 

## future artificat, 
function selectEditVSCode_experiment() {
    filename=$1
    # select file
    selectedFile="${ fzf $filename }"
    code -w $selectedFile
}



### - -   is_WSLv2_🐧💙🪟v2   - - \\
## Microsoft Windows Linux Subsystem II  WSL2
## 🤓 https://docs.microsoft.com/en-us/windows/wsl/install-win10
#
function is_WSLv2_🐧💙🪟v2() {
    return `cat /proc/version | grep -c "microsoft-standard-WSL2"`
}
### - -  ..  - - //


# 🍰 https://stackoverflow.com/questions/3963716/how-to-manually-expand-a-special-variable-ex-tilde-in-bash/29310477#29310477
# converts string ~/.b00t to actual path
# usage: path=$(expandPath '~/hello')
function expandPath() {
  local path
  local -a pathElements resultPathElements
  IFS=':' read -r -a pathElements <<<"$1"
  : "${pathElements[@]}"
  for path in "${pathElements[@]}"; do
    : "$path"
    case $path in
      "~+"/*)
        path=$PWD/${path#"~+/"}
        ;;
      "~-"/*)
        path=$OLDPWD/${path#"~-/"}
        ;;
      "~"/*)
        path=$HOME/${path#"~/"}
        ;;
      "~"*)
        username=${path%%/*}
        username=${username#"~"}
        IFS=: read -r _ _ _ _ _ homedir _ < <(getent passwd "$username")
        if [[ $path = */* ]]; then
          path=${homedir}/${path#*/}
        else
          path=$homedir
        fi
        ;;
    esac
    resultPathElements+=( "$path" )
  done
  local result
  printf -v result '%s:' "${resultPathElements[@]}"
  printf '%s\n' "${result%:}"
}




##* * * * * *\\
## generates a random number between 0 and \$1
# usage: 
# rand0_result="$(rand0 100)"
# echo \$rand0_result

function rand0() {
    local args=("$@")
    local max=${args[0]}
    rand0=$( bc <<< "scale=2; $(printf '%d' $(( $RANDOM % $max)))" ) ;
    # rand0=$( echo $RANDOM % $max ) ; 
    echo $rand0
}

##* * * * * *//
## checks to see if an alias has been defined. 
#  if is_n0t_aliased "az" ; then echo "true - not aliased!"; else echo "false"; fi
function is_n0t_aliased() {
    local args=("$@")
    local hasAlias=${args[0]}
    local exists=$(alias -p | grep "alias $hasAlias=")
    # echo "exists: $exists"
    if [ -z "$exists" ] ; then
        # 🙄 exists: alias fd='/usr/bin/fdfind'
        return 0;  # "true", unix success
    else 
        return 1;  #  "false", unix error
    fi
}


##
## A pretty introduction to the system. 
##
function motd() {
    # count motd's
    # 🍰 https://unix.stackexchange.com/questions/485221/read-lines-into-array-one-element-per-line-using-bash
    SED_PATH=$(whereis -b sed | cut -f 2 -d ' ')

    if is_n0t_aliased "fd" ; then
        # no fd, incomplete environemnt
        log_📢_记录 "🥾🍒 No fd alias, incomplete environment"
        if [ ! -f "/tmp/motd.txt" ] ; then 
            printf "\nb00t basic motd. generated %s\n\n" $(ymd_hms) > "/tmp/motd.txt"
        fi 
        motdz=('/tmp/motd.txt')
    else 
        readarray -t motdz < <(/usr/bin/fdfind .txt "$_B00T_C0DE_Path/./ubuntu.🐧/etc/")
    fi
    local motdzQ=$( rand0 ${#motdz[@]} )
    # declare -p motdz

    local showWithCMD=$(echo batOrCat)
    
    f=${motdz[motdzQ]}
    local motdWidth=$(awk 'length > max_length { max_length = length; longest_line = $0 } END { print max_length }' $f)
    # local motdWidth=$(cat "${motdz[motdzQ]}" | tail -n 1)
    local motdLength=$(cat $f | wc -l)

    local myWidth=$(tput cols)
    local myHeight=$(tput rows)
    if [ -z "$myHeight" ] ; then myHeight='🍒😑' ; fi
    log_📢_记录 "🥾🖥️ motd .cols: $motdWidth  .rows:$motdLength"
    log_📢_记录 "🤓🖥️ user .cols: $myWidth  .rows:$myHeight"
        
    if [ $motdWidth -gt "$myWidth" ] ; then 
        echo "👽:太宽 bad motd. too wide."
        showWithCMD=""
    elif [ $motdWidth -gt $(echo $myWidth - 13 | bc) ] ; then
        # bat needs +13 columns
        showWithCMD="cat"
    elif ! command -v bat &> /dev/null 
    then
        # bat needs +13 columns
        showWithCMD="cat"
    else
        # *auto*, full, plain, changes, header, grid, numbers, snip.
        showWithCMD="batOrcat --pager=never --style=plain --wrap character"
        if [ $(rand0 100) -gt 69 ] ; then 
            showWithCMD="batcat --pager=never --wrap character"
        fi
    fi
    # if it's still too big, try again!

    ## sometimes, cat is nice!
    if [ -z "$showWithCMD" ] ; then
        echo "👽💩: 烂狗屎 cannot motd."
    elif [ "$(rand0 10)" -gt 5 ] ; then 
        showWithCMD="cat"
    fi 

    local glitchCMDz=''
    if [ $(rand0 10) -gt 1 ] ; then
        glitchCMDz="$glitchCMDz | $SED_PATH 's/1/0/g' "
    fi
    #if [ $(rand0 10) -gt 5 ] ; then
    #    glitchCMDz=" | $SED_PATH 's/0/1/g' $glitchCMDz"
    #fi
    #if [ $(rand0 10) -gt 5 ] ; then
    #    glitchCMDz=" | $SED_PATH 's/8/🥾/g' $glitchCMDz"
    #fi

    #if [ $motdLength -gt $(echo $(tput rows) - 3 | bc) ] ; then
    #    showWithCMD="cat"
    #fi 

    if [ -n "$showWithCMD" ] ; then
        motdTmpFile=$( mktemp "_b00t_.日$(ymd).一时XXXXXXXXXX.motd" )
        # echo "motdFile: $motdTmpFile"
        # echo $(rand0 10)
        ## glitch effects 
        cp -v ${motdz[motdzQ]} $motdTmpFile
        if [ $(rand0 10) -gt 5 ] ; then
            $SED_PATH -i 's/1/0/g' $motdTmpFile
            $SED_PATH -i 's/8/🥾/g' $motdTmpFile
        fi 
        if [ $(rand0 10) -gt 5 ] ; then
            $SED_PATH -i 's/\*/🥾/g' $motdTmpFile
            $SED_PATH -i 's/[\!\-\@]./😁/g' $motdTmpFile
        fi
        if [ $(rand0 10) -gt 5 ] ; then
            $SED_PATH -i 's/#/_/g' $motdTmpFile
            $SED_PATH -i 's/0/🐛/g' $motdTmpFile
        fi 
        if [ $(rand0 10) -gt 5 ] ; then
            $SED_PATH -i 's/1/l/g' $motdTmpFile
            $SED_PATH -i 's/[\@l\#]/🐛/g' $motdTmpFile
        fi 
        $showWithCMD $motdTmpFile
        /bin/rm -f $motdTmpFile
    fi

    # part of motd

    log_📢_记录 "lang: $LANG"
    log_📢_记录 "🥾📈 motd project stats, cleanup, tasks goes here. "


    if [ -d "./.git" ] ; then 
        log_📢_记录 "🥾🐙😁 found .git repo"
        # github client 
        gh issue list

        local skunk_x=$(git grep "🦨" | wc -l)
        log_📢_记录 "🦨: $skunk_x"
    else 
        log_📢_记录 "🥾🐙😔 no .git dir "`pwd`
    fi 

}

if [ "${container+}" == "docker" ] ; then
    motd
elif ! is_n0t_aliased fd ; then 
    motd
else 
    motd
fi





# export FZF_COMPLETION_OPTS='--border --info=inline'
if ! n0ta_xfile_📁_好不好 "/usr/bin/fdfind"  ; then
    # export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | /usr/bin/fdfind --type f --type l $FD_OPTIONS"
    # export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview=[[ \$file --mine{}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind'f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
    # from video: https://www.youtube.com/watch?v=qgG5Jhi_Els
    export FZF_DEFAULT_COMMAND="/usr/bin/fdfind --type f"
fi



##
## there's time we need to know reliably if we can run SUDO
##
function has_sudo() {
    SUDO_CMD="/usr/bin/sudo"

    ## 🦨 TODO: ask for consent to run sudo? 

    if [ "$EUID" -eq 0 ] ; then
        # r00t doesn't require sudo 
        # https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
        log_📢_记录 "👹 please don't b00t as r00t"
        SUDO_CMD=""
    elif [ -f "./dockerenv" ] ; then
        # https://stackoverflow.com/questions/23513045/how-to-check-if-a-process-is-running-inside-docker-container#:~:text=To%20check%20inside%20a%20Docker,%2Fproc%2F1%2Fcgroup%20.
        log_📢_记录 "🐳😁 found DOCKER"  
    elif [ -f "$SUDO_CMD" ] ; then 
        #if [[ -z $( crudini_get "b00t" "has.sudo" )  ]] ; then 
            log_📢_记录 "🥳 found sudo"  
        #     crudini_set "b00t" "has.sudo" `ymd_hms`
        #fi 
    else 
        log_📢_记录 "🐭 missed SUDO, try running _b00t_ inside docker."
        SUDO_CMD=""
    fi
    export SUDO_CMD
}
# note: trying to remove sudo from requirements.
#has_sudo 








# 60秒 Miǎo seconds
# 3分钟 Fēnzhōng minutes
# 3小时 Xiǎoshí seconds






# export _b00t_JS0N_filepath=$(expandPath "~/.b00t/config.json")
#function jqAddConfigValue () {
#    echo '{ "names": ["Marie", "Sophie"] }' |\
#    jq '.names |= .+ [
#        "Natalie"
#    ]'   
#}


# 🍰 https://lzone.de/cheat-sheet/jq
#function jqSetConfigValue () {
#
#    echo '{ "a": 1, "b": 2 }' |\
#jq '. |= . + {
#  "c": 3
#}'
#}



# RUST
source $HOME/.cargo/env


# nvm (node version manager)
if ! command -v nvm &> /dev/null
then 
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  #
fi





##
export _user="$(id -u -n)" 
export _uid="$(id -u)" 
echo "🙇‍♂️ \$_user: $_user  \$_uid : $_uid"
set +euxo nounset 

