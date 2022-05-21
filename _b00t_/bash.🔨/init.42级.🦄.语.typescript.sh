## * * * *// 
#* Purpose: 🦄 b00tstraps node & typescript
#* mostly placeholder
## * * * *\\




set -o xtrace

if [ -z "$_B00T_C0DE_Path" ] ; then 
    _B00T_C0DE_Path="./."
fi


#* 进口v2 🥾 ALWAYS load c0re Libraries!
source "$_B00T_C0DE_Path/_b00t_.bashrc"

# once we setup npm
# 🤓 ZX: a tool for writing better scripts. 
# https://github.com/google/zx
#
# BASH: 
#  await $`cat package.json | grep name`

#  let branch = await $`git branch --show-current`
#  await $`dep deploy --branch=${branch}`

#  await Promise.all([
#     $`sleep 1; echo 1`,
#     $`sleep 2; echo 2`,
#     $`sleep 3; echo 3`,
#   ])
#

# curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

## Run `sudo apt-get install -y nodejs` to install Node.js 14.x and npm

# 
# https://nodejs.org/dist/latest/docs/api/corepack.html

## 🧶 To install the Yarn package manager, run:
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list     
sudo apt-get update -y && sudo apt-get -y install yarn
pathAdd "$HOME/.yarn/bin"

# Yarn v2 https://yarnpkg.com/getting-started/migration
yarn set version berry


# not even sure we need NPM. 
# npm install -g npm@latest


# let name = 'foo bar'
# await $`mkdir /tmp/${name}`
# npm i -g zx
# curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
# https://linuxize.com/post/how-to-install-node-js-on-ubuntu-20-04/#installing-nodejs-and-npm-from-nodesource


# YARN Node package manager (use method above)
# 🤓 https://engineering.fb.com/2016/10/11/web/yarn-a-new-package-manager-for-javascript/
# yarn add create
#if [ ! -x "/usr/local/bin/yarn" ]; then 
#    $SUDO_CMD npm install -g yarn
#    # yarn add $project
#    # npm init @vitejs/app <project-name>
#    # yarn create @vitejs/app <project-name>
#fi 

#yarn add nvm 
yarn add vue

# yarn create @vitejs/app <-- deprecated
## yarn create vite

# Docker SDK
yarn add @docker/sdk

# install dependencies as you code
# https://github.com/siddharthkp/auto-install

# 
# yarn create @vitejs/app _b00t_

# Three examples of PolyMorphism:
# https://blog.sessionstack.com/how-javascript-works-3-types-of-polymorphism-f10ff4992be1?source=collection_category---4------0-----------------------&gi=d6058f27a8e3

# ShellJS a portable unix shell commands for node.js
# https://github.com/shelljs/shelljs

# future.

# log_📢_记录 "🚀 install node"
#sudo snap install node --classic

## Foy makes all the cool node setup scripts with animated installers. 
#npm i -D foy

## Yeoman is awesome. Going to use this: 
#npm install -g yo generator-code

# https://www.npmjs.com/package/vue-cli-plugin-vite
# existing vue project?
# vue add vitejs
# yarn vite 

## NEXT:           
# https://github.com/actions/setup-node         
# https://github.com/marketplace/actions/github-action-for-yarn

# https://github.com/Testy/TestyTs

yarn add --dev testyts
npm install --save-dev testyts
npm install -g testyts
testyts init

yarn @tsconfig/deno

