#!/bin/bash

# default push location
REMOTE="origin"
BRANCH="dev"

# custom checking for origin and master
if [ $# -eq "2" ]
then
  REMOTE="$1"
  BRANCH="$2"
elif [ $# -eq "1" ]
then
  REMOTE="$1"
elif [ $# -gt "2" ]
then
  echo "Invalid usage of the script"
  echo "usage: ./git.sh [origin] [branch]"
  exit 1
fi

# Branch validaton
if [ "$BRANCH" == "master" ]
then
  read -p "Are you sure you would select $BRANCH? (yes/no) " cond
  if [ "$cond" != "yes" ]
  then
    echo "process has been terminated......."
    echo "usage: ./git.sh [origin] [branch]"
    exit 1
  fi
else
  echo "not selected master branch"
  # Get all the branch list
  hasDev=$(echo $(git branch) | grep -o "dev" | wc -w)
  if [ $hasDev -eq "1" ]
  then
    echo "dev branch exist..."
  else
    echo "dev branch doesn't exist...."
  fi

fi

# Git commit message
# read -p "Enter commit message here: " MSG

# Git commands
# git add .
# git commit -m "$MSG"
# git push $REMOTE $BRANCH