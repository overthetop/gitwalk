#!/bin/bash

die() {
  echo "$*" 1>&2
  exit 1
}

validate_args() {
  if [[ -z $clone ]]; then
    die "Missing parameter --clone"
  elif [[ -z $clone_src ]]; then
    die "Missing parameter --clone_src"
  elif [[ -z $pull ]]; then
    die "Missing parameter --pull"
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

if $clone == 'true'; then
  while IFS= read -r line
  do
    echo $line ; git clone $line;
  done < "$clone_src"
fi

for i in ./**; do
  if [ -d "$i" ]; then
    cd $i
    if [ -d .git ]; then
      git remote -v | awk 'NR==1{print $2}'
      if $pull == 'true'; then
        git status
        git pull
      fi
    fi
    cd ..
  fi
done
