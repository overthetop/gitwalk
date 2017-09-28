#!/bin/bash


destination=''
while getopts ":d:" opt; do
  case $opt in
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      destination="$OPTARG";
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
if [ ! -d "$destination" ]; then
	mkdir $destination
fi
cd $destination;
pwd
while read x ; do
 echo $x ; git clone $x;
done
cd ..
pwd
