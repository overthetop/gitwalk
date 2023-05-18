#!/bin/bash

pwd
while read x ; do
 echo $x ; git status; git pull $x;
done

