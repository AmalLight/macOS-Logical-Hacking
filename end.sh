#!/bin/bash

sudo mkdir -p /usr/local/bin

dir=Users/kaumi

sudo ln -sf /$dir/my.sh        /usr/local/bin/my
sudo ln -sf /$dir/end.sh       /usr/local/bin/end
sudo ln -sf /$dir/searchfor.sh /usr/local/bin/searchfor
sudo ln -sf /$dir/enablessh.sh /usr/local/bin/enablessh

sudo rm -f /usr/local/bin/brew

rm -rf /$dir/.bash_sessions
rm -rf /$dir/.bash_history
rm -rf /$dir/.zsh_history
rm -rf /$dir/.python_history
rm -rf /$dir/.CFUserTextEncoding

echo ''

str='eval $(/opt/homebrew/bin/brew shellenv)'

echo "string : $str , to paste . already copied"

echo -n $str | pbcopy

echo ''
