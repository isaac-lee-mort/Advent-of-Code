#!/bin/bash
mkdir -p pseudoFS
startDir=$(pwd)
filesystemSize=70000000
unusedSpaceNeeded=30000000
limit=100000
smallestDirDelete=70000000
totalSize=0
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
allDirsSize=$(find pseudoFS -type f -exec wc -c {} + | tail -n1 | awk '{print $1}')
currentFreeSpace=$(expr $filesystemSize - $allDirsSize)
spaceToDelete=$(expr $unusedSpaceNeeded - $currentFreeSpace)

for i in $(cat directories); do
    dirSize=$(find $i -type f -exec wc -c {} + | tail -n1 | awk '{print $1}')
    if [[ $dirSize -le $limit ]]; then
        totalSize=$((totalSize + $dirSize))
    fi
    if [[ $dirSize -ge $spaceToDelete ]]; then
        if [[ $dirSize -le $smallestDirDelete ]]; then
            smallestDirDelete=$dirSize
        fi
    fi
done
echo "Size of directories less than $limit is $totalSize"
echo "Size of smallest directory to delete is $smallestDirDelete"
rm -rf pseudoFS directories