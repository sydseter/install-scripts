#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

comp_ver="$(composer --version)";
if [ -n "$comp_ver" ];then exit 0;fi;

pushd $DIR/../;
curl -sS https://getcomposer.org/installer | php && \
sudo mv composer.phar /usr/local/bin/composer;
popd;
