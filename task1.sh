#!/bin/bash

loc=$1;
if [[ $1 == "" ]]
then
	loc=`pwd`;
fi
number=`git log --oneline|wc -l`;
name=(`git log -1 --sparse | head -n 2| tail -n 1| sed -r 's/[<>]+/ /g'`);
comment=`git log -1 --sparse | awk 'NR>4'|awk '{$1=$1};1'` ;

echo "Author's name is: '${name[1]}' and E-mail id is '${name[2]}'
The number of commits is : $number
The comment of the last commit is: '$comment'";
