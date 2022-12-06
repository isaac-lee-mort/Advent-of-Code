#!/bin/bash
datastream=$(cat input.txt)
condition=FALSE
position=0

while [ $condition == "FALSE" ]; do
    first=$(echo ${datastream:$position:1})
    second=$(echo ${datastream:$position +1:1})
    third=$(echo ${datastream:$position +2:1})
    fourth=$(echo ${datastream:$position +3:1})
    numberUnique=$(echo $first $second $third $fourth | tr ' ' '\n' | sort | uniq -c | grep '1' | wc -l)
    if [ $numberUnique -eq "4" ]; then
        startPosition=$(expr $position + 4 )
        echo "Start Position is $startPosition"
        condition=TRUE
    fi
    position=$(expr $position + 1)
done