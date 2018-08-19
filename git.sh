#!/bin/bash

# default push location
REMOTE="origin"
BRANCH="dev"

# custom checking for origin and master
if [ $# -eq "2" ]
then
  # Two arguments script call
  REMOTE="$1"
  BRANCH="$2"
elif [ $# -eq "1" ]
then
  # One arguments script call
  REMOTE="$1"
elif [ $# -gt "2" ]
then
  # Invalid script call
  echo "Invalid usage of the script"
  echo "usage: ./git.sh [origin] [branch]"
  exit 1
fi

# local staging
git add .

# Git commit message
read -p "Enter commit message here: " MSG
git commit -m "$MSG"

# Branch validaton
if [ "$BRANCH" == "master" ]
then
  # Branch is master branch then
  read -p "Are you sure you would select $BRANCH? (yes/no): " cond

  # Don't want to push to master then
  if [ $(echo "$cond" | tr '[:upper:]' '[:lower:]') != "yes" ]; 
  then
    echo "process has been terminated......."
    echo "usage: ./git.sh [origin] [branch]"
    exit 1
  fi
else
  echo "not selected master branch"
  # Get all the branch list and check for dev branch
  if [ $(echo $(git branch) | grep -o "dev" | wc -w) -eq "0" ]
  then
    # dev branch doesn't exist
    read -p "would you like to create dev branch and switch to it?(yes/no): " cond
    if [ $(echo "$cond" | tr '[:upper:]' '[:lower:]') == "yes" ]; 
    then
      # Created dev branch and switched into it.
      git checkout -b dev
    fi
  else
    # dev branch exist....
    # yet to add dev branch scripts
  fi
fi

# Validating REMOTE
if [ $(echo $(git remote) | grep -o $REMOTE | wc -w) -eq "0" ];
then
  # REMOTE does not exist
  read -p "Enter a name to the remote repository: " REMOTE
  read -p "Enter $REMOTE repository URL: " URL

  # Create a new remote for the respository
  git remote add $REMOTE $URL
fi

# Pull and then push to avoid conflicts.
git pull $REMOTE $BRANCH
git push $REMOTE $BRANCH