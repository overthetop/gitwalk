#!/bin/bash

function setBoolean() {
  local v
  if (( $# != 2 )); then
     echo "Err: setBoolean usage" 1>&2; exit 1 ;
  fi

  case "$2" in
    TRUE) v=true ;;
    FALSE) v=false ;;
    *) echo "Err: Unknown boolean value \"$2\"" 1>&2; exit 1 ;;
   esac

   eval $1=$v
}

p=false
if ! [ -z "$2" ]; then
    setBoolean p "$2"
fi


cd $1
for i in $1/** ; do
  if [ -d "$i" ]; then
    cd $i
	if [ -d .git ]; then
	    git remote -v | awk 'NR==1{print $2}'
      if $p; then
          git status
          git pull
      fi
	fi
    cd ..

  fi
done
