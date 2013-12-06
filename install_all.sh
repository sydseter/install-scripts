#!/usr/bin/env bash
function say () {
    printf "${bldwht}%b${txtrst}\n" "$*";
}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
pushd $DIR;
./install_composer.sh && say "Installed Composer globally.";
./install_node.sh && say "Installed Node globally.";
./install_node_modules.sh &&  say "Installed node modules locally.";
popd;
