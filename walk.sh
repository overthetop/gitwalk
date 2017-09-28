#!/bin/bash

cd $1
for i in $1/** ; do
  if [ -d "$i" ]; then
    cd $i
	if [ -d .git ]; then
	    git remote -v | awk 'NR==1{print $2}'
	fi
    cd ..

  fi
done
