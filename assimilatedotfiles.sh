#!/bin/bash
#=========================================================================================
# assimilatedotfiles.sh
# Ronald Wochner 
# Tue 04 Jun 2019 11:35:55 AM UTC
# Version 1
# Simple bash script to pull dotfiles and set them up
# Script based on instructions and example from: https://www.atlassian.com/git/tutorials/dotfiles
#=========================================================================================

repo=$1

# Check that all args are given
if [ $# -lt 1 ]
then 
    echo "Usage: $0 \"repo path"
    exit
fi



git clone --bare $repo $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
    echo "Backup complete, checking out files"
fi;
config checkout
config config status.showUntrackedFiles no

