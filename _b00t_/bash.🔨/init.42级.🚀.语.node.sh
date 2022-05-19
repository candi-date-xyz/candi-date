## * * * *// 
#* Purpose: 🦄 b00tstraps node & typescript
#* should be called directly from ./01-start.sh 
## * * * *\\

set -o xtrace

if [ -z "$_B00T_C0DE_Path" ] ; then 
    _B00T_C0DE_Path="./."
fi

#* 进口v2 🥾 ALWAYS load c0re Libraries!
source "$_B00T_C0DE_Path/_b00t_.bashrc"

# nvm - node version manager
if ! command -v nvm &> /dev/null
then 
    log_📢_记录 "🚀 install nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  #

nvm install --lts Gallium
nvm install-latest-npm

# snap is sh*t. 
# $SUDO_CMD snap install node --classic
# $SUDO_CMD apt-get install -y npm

npm i -D foy

## Yeoman is awesome. Going to use this: 
npm install -g yo generator-code


