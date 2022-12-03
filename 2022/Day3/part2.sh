#!/bin/bash
source variables
runningTotal=0
start=1
group=1
groups=$(expr $(wc -l rucksacks.txt | awk '{print $1}') / 3)

while [ $group -le $groups ]; do
    sed -n $(expr $start + 0)p rucksacks.txt > line0.txt
    sed -n $(expr $start + 1)p rucksacks.txt > line1.txt
    sed -n $(expr $start + 2)p rucksacks.txt > line2.txt
    firstCommon=$(comm -12 <(fold -w1 line0.txt | sort -u) <(fold -w1 line1.txt | sort -u) | tr -d '\n')
    secondCommon=$(comm -12 <(fold -w1 <<< $firstCommon | sort -u) <(fold -w1 line2.txt | sort -u) | tr -d '\n')
    runningTotal=$(expr $runningTotal + ${!secondCommon})
    group=$(expr $group + 1)
    start=$(expr $start + 3)
done
rm -f line*.txt

echo $runningTotal