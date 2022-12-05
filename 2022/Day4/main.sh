#!/bin/bash
enclosedRunningTotal=0
overlappingRunningTotal=0
cat sections.txt | while read line; do
    elfOne=$(echo $line | cut -d ',' -f1)
    elfTwo=$(echo $line | cut -d ',' -f2)
    elfOneStart=$(echo $elfOne | cut -d '-' -f1)
    elfOneEnd=$(echo $elfOne | cut -d '-' -f2)
    elfTwoStart=$(echo $elfTwo | cut -d '-' -f1)
    elfTwoEnd=$(echo $elfTwo | cut -d '-' -f2)
    if [ $elfOneStart -le $elfTwoStart ] && [ $elfTwoEnd -le $elfOneEnd ]; then
        enclosedRunningTotal=$(expr $enclosedRunningTotal + 1)
    elif [ $elfTwoStart -le $elfOneStart ] && [ $elfOneEnd -le $elfTwoEnd ]; then
        enclosedRunningTotal=$(expr $enclosedRunningTotal + 1)
    fi
    
    if [ $elfTwoStart -ge $elfOneStart ] && [ $elfTwoStart -le $elfOneEnd ]; then
        overlappingRunningTotal=$(expr $overlappingRunningTotal + 1)
    elif [ $elfTwoEnd -ge $elfOneStart ] && [ $elfTwoEnd -le $elfOneEnd ]; then
        overlappingRunningTotal=$(expr $overlappingRunningTotal + 1)
    elif [ $elfOneStart -ge $elfTwoStart ] && [ $elfOneStart -le $elfTwoEnd ]; then
        overlappingRunningTotal=$(expr $overlappingRunningTotal + 1)
    elif [ $elfOneEnd -ge $elfTwoStart ] && [ $elfOneEnd -le $elfTwoEnd ]; then
        overlappingRunningTotal=$(expr $overlappingRunningTotal + 1)
    fi

    echo $enclosedRunningTotal > tmp.txt    
    echo $overlappingRunningTotal >> tmp.txt
done
cat tmp.txt
rm tmp.txt