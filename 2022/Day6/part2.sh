#!/bin/bash
datastream=$(cat input.txt)
condition=FALSE
position=0

while [ $condition == "FALSE" ]; do
    for i in {0..13}; do
        echo ${datastream:$position +$i:1} > character$i
    done
    numberUnique=$(cat character* | sort | uniq -c | grep '1' | wc -l)
    if [ $numberUnique -eq "14" ]; then
        startPosition=$(expr $position + 14 )
        echo "Start Position is $startPosition"
        condition=TRUE
    fi
    position=$(expr $position + 1)

done

rm -f character*