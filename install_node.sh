#!/usr/bin/env bash

# http://stackoverflow.com/questions/4023830/bash-how-compare-two-strings-in-version-format
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

check_node_version() {
    if [ $(node -v) ]
    then
        local node_ver=$(node -v | sed 's/[^0-9.]*\([0-9.]*\).*/\1/');
        local min_ver='0.10.0';
        vercomp "$node_ver" $min_ver;
        if [ $? -ne "2" ];then exit 0;fi;
    fi
}

check_node_version;

pushd $DIR;
cd /var/tmp
sudo apt-get install g++ curl libssl-dev apache2-utils && \
sudo apt-get install git-core && \
git clone git://github.com/ry/node.git && \
cd node && \
git checkout v0.10.22-release && \
./configure && \
make && \
make test && \
sudo make install && \
cd ../ && \
rm -rf node;
popd;
