#!/bin/bash
source variables
runningTotal=0
cat rucksacks.txt | while read line; do
    echo '############'
    firstHalf=${line:0:${#line}/2}
    secondHalf=${line:${#line}/2}
    sameItems=$(comm -12 <(fold -w1 <<< $firstHalf | sort -u) <(fold -w1 <<< $secondHalf | sort -u))
    runningTotal=$(expr $runningTotal + ${!sameItems})
    echo $runningTotal
done