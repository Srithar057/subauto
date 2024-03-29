#!/bin/bash
RED='\033[1;31m'
RESET='\033[0m'
input="$1"

subfinder=$(~/go/bin/./subfinder -d "$1" -silent > .subfinder.log 2>&1 )
assetfinder=$(~/go/bin/./assetfinder "$1" | tee .assetfinder.log)
findomain=$(findomain -t "$1" -u .findomain.log)
filter=$(cat .subfinder.log .assetfinder.log .findomain.log | sort -u > .unique.log)
find=$(cat .unique.log | grep "$1" > .find.log)
live=$(cat .find.log | ~/go/bin/./httpx -silent > live.txt)
count=$(cat live.txt | wc -l)
final=$(cat live.txt)
printf "$final"
printf "\n"
rm .subfinder.log .assetfinder.log .findomain.log .unique.log .find.log
echo -e "${RED}Overall Count:${RESET} $count"