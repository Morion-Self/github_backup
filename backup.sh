#!/bin/bash

TOKEN=$1

readarray REPOS < <( \
  curl -H 'Authorization: token '$TOKEN "https://api.github.com/user/repos?per_page=100" | \
  grep -e 'full_name' | \
  cut -d \" -f 4
)

mkdir github_backups
cd github_backups

for i in "${REPOS[@]}"
do
  str=`echo $i | sed 's/ *$//g'` # trim
  git clone "https://$TOKEN@github.com/"$str".git" $str
done
