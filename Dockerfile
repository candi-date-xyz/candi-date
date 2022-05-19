# syntax=docker/dockerfile:latest

## 
## DOCKER TUTORIAL: 
##

# TO BUILD:
# ./docker-build.sh 
# TO RUN:

# Docker uses the default 172.17.0.0/16 subnet for container networking. 

# FUTURE TODO: 
# FROM python:3.7-alpine
# shows secret from default secret location:
# RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret
# USER root 
# SHELL /bin/bash

# 🤓 Dockerfile Best Practices
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# 🤓 Buildkit syntax 
# https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/syntax.md

# PODMAN on WSL2
# https://dev.to/thangchung/start-podman-on-wsl2-in-4-steps-3jn9

# https://code.visualstudio.com/docs/remote/containers-tutorial


# docker CLI syntax
# -f   ::  changes context

# 🤔 Dockerfile can be sent via stdin
# tools like terraform, etc. can generate these
# there is also developer libraries 

# passing ARGS
# An ARG declared before a FROM is outside of a build stage, 
# AND therefore can’t be used in any instruction after a FROM
# ARG outside_build_stage

# Environment variables
# ${variable_name} syntax also supports a few of the standard bash modifiers as specified below:
# ${variable:-word} indicates that if variable is set then the result will be that value. If variable is not set then word will be the result.
# ${variable:+word} ndicates that if variable is set then word will be the result, otherwise the result is the empty string.



#### 
# Step1: init
# https://hub.docker.com/_/ubuntu
# FROM jrei/systemd-ubuntu as b00t_1n1t
FROM ubuntu:focal as b00t_up
LABEL 🥾🐳 b00t_up
ARG arrgh 
ENV "STAGE"="1n1t"
RUN echo "🥾🐳 1n1t" && echo "STAGE: ${STAGE} arrgh: ${arrgh}"


## make logs persistent 
VOLUME ["/var/log" ]

## the git repo's will be mounted here. 
VOLUME ["/c0de" ]

RUN echo "apt update -y && apt upgrade -y && apt-get install -y apt-utils"

## NOTE: if squid caching proxy had issue, these lines can cache bad values. 
# RUN apt-get clean && apt-get update -y && apt-get upgrade -y

# Timezone
RUN echo "🥾cat utf8"
ENV DEBIAN_FRONTEND "noninteractive"
ENV TZ "Australia/Melbourne"

# from https://hub.docker.com/_/ubuntu
RUN apt-get update && apt-get install -y tzdata apt-utils locales && rm -rf /var/lib/apt/lists/*
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Emoji Support
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#### 
# Step2: base (everything)
FROM b00t_up as b00t_init
LABEL 🥾🐳 init


## DOCKER BUILD ENHANCEMENTS
## https://docs.docker.com/develop/develop-images/build_enhancements/
## 
# download github public key
#RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
# clone private repo
#RUN --mount=type=ssh git clone git@github.com:myorg/myproject.git myproject
# HINT use depth of 1 to limit the history i.e.
# git clone --depth <depth> -b <branch> <repo_url>
# 🤓: https://stackoverflow.com/questions/29368837/copy-a-git-repo-without-history

# must run
# $ docker build --ssh default .
# docker --compress

## Dev/test git, gcc, g++
## podman/buildah doesn't work with cache?
#RUN --mount=type=cache,target=/var/cache/apt \
#    --mount=type=cache,target=/var/lib/apt \
#    apt update && apt-get --no-install-recommends install -y apt-utils git gcc g++
#RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
#  apt update && apt-get --no-install-recommends install -y gcc
#RUN --mount=type=cache,target=/var/cache/apt \
#    --mount=type=cache,target=/var/lib/apt \
RUN  apt update && apt-get --no-install-recommends install -y apt-utils git gcc g++

RUN apt-get update && apt-get install -y git gcc g++
RUN git --version
# RUN apt-get install -y apt-utils curl wget 
# # ca-certificates gnupg 


#############################################################

# BASE (an interim step)
FROM b00t_init as b00t_base
RUN echo "🥾🐳 B4S3 (base)"
MAINTAINER ops@elastic.ventures

#############################################################

FROM b00t_base as b00t_make


## DOCKER BUILD ENHANCEMENTS
## https://docs.docker.com/develop/develop-images/build_enhancements/
##
# download github public key
#RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
# clone private repo
#RUN --mount=type=ssh git clone git@github.com:myorg/myproject.git myproject
# must run
# $ docker build --ssh default .
# docker --compress

## Dev/test git, gcc, g++
#RUN --mount=type=cache,target=/var/cache/apt \
#    --mount=type=cache,target=/var/lib/apt \
#    apt update && apt-get --no-install-recommends install -y apt-utils git gcc g++

# RUN apt-get update && apt-get install -y git gcc g++
RUN git --version
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y apt-utils dialog curl wget ca-certificates gnupg

# https://github.com/tianon/gosu/blob/master/INSTALL.md
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

## create a user account (with docker privileges)
# https://stackoverflow.com/questions/27701930/how-to-add-users-to-docker-container
# RUN gosu groupadd docker
# RUN useradd --create-home --gid docker brianh

# TODO: setup ps1, etc.

VOLUME "/c0de/candi-date/"
#COPY ./docker.🐳 /c0de/_b00t_/docker.🐳/
WORKDIR /c0de/candi-date/

COPY .  "/c0de/candi-date"
# ADD ./*.bashrc "./"
# ADD /c0de/
RUN chmod +x ./install.sh
RUN ./install.sh

## this was screwing up permissions:
#RUN useradd -ms /bin/bash brianh
#USER brianh
#WORKDIR /home/brianh

## Stage2
# CURRENT ISSUE:
# file always rebuilds, full build takes too long,
# not using stages YET
#RUN /c0de/_b00t_/source.sh "./bash.🔨/init.*.🥾.*.sh";
#RUN --mount=type=bind,target="/c0de/b00t",ro
# ADD "./_b00t_.bashrc" "./"
# ADD "./source.sh" "./"
# RUN chmod +x "_b00t_.bashrc"
  
CMD [ "/bin/bash", "-c", "/c0de/_b00t_/_b00t_.bashrc"]
#CMD [ "/bin/bash", "-c", "/c0de/install.sh"]

# works:
#sudo service dbus start

# doesn't work, no systemd on WSL2
#sudo dbus-daemon --system
 #systemctl status --system
 #systemctl status --user

#systemctl --user daemon-reload
#systemctl restart dbus


# Failed to connect to bus: $DBUS_SESSION_BUS_ADDRESS and $XDG_RUNTIME_DIR not defined (consider using --machine=<user>@.host --user to connect to bus of other user)


# FUTURE RESEARCH
# https://y0n1.medium.com/using-podman-with-the-docker-extension-for-visual-studio-code-a828be26d285

# https://hub.docker.com/r/grycap/scar/
# https://github.com/cockpit-project/cockpit-podman