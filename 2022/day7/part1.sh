#!/bin/bash
mkdir -p pseudoFS
startDir=$(pwd)
totalSize=0
limit=100000
cat history.txt | while read i; do
    if echo $i | egrep -q '^\$'; then
        command=$(echo $i | cut -f 2- -d ' ')
        if [[ $command == "cd /" ]]; then
            cd pseudoFS
        elif [[ $command == "ls" ]]; then
            touch history.txt
        else
            $command
        fi
    elif echo $i | egrep -q '^dir'; then
        directory=$(echo $i | cut -f 2- -d ' ')
        mkdir -p $directory
    else
        fileSize=$(echo $i | cut -f 1 -d ' ')
        file=$(echo $i | cut -f 2- -d ' ')
        mkfile -n $fileSize $file
    fi
done

cd $startDir
find pseudoFS -type d > directories

for i in $(cat directories); do
    dirSize=$(find $i -type f -exec wc -c {} + | tail -n1 | awk '{print $1}')
    if [[ $dirSize -le $limit ]]; then
        totalSize=$((totalSize + $dirSize))
    fi
done
echo "Size of directories less than $limit is $totalSize"
rm -rf pseudoFS directories