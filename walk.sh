#!/bin/bash

die() {
  echo "$*" 1>&2
  exit 1
}

validate_args() {
  if [[ -z $src ]]; then
    die "Missing parameter --src"
  elif [[ -z $pull_it ]]; then
    die "Missing parameter --pull_it"
  fi
}

while [ $# -gt 0 ]; do
  if [[ $1 == "--"* ]]; then
    v="${1/--/}"
    declare "$v"="$2"
    shift
  fi
  shift
done

validate_args

cd $src
for i in $src/**; do
  if [ -d "$i" ]; then
    cd $i
    if [ -d .git ]; then
      git remote -v | awk 'NR==1{print $2}'
      if $pull_it == 'true'; then
        git status
        git pull
      fi
    fi
    cd ..
  fi
done
