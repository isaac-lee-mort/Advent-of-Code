#!/bin/bash
awk -F'\t' '{print ($1?$1:"NEXT")}' calorieCount.txt> tmp.txt
runningTotal=0
for i in `cat tmp.txt`; do
    if [ $i == "NEXT" ]; then
        elfArray+=("$runningTotal")
        runningTotal=0
    else
        runningTotal=$(expr $runningTotal + $i)
    fi
done
echo "Highest Total Calories -- `echo "${elfArray[*]}" | sed 's/ /\n/g' | sort -nr | head -n1`"
echo "${elfArray[*]}" | sed 's/ /\n/g' | sort -nr | head -n3> tmp.txt
for i in `cat tmp.txt`; do
    runningTotal=$(expr $runningTotal + $i)
done
echo "Sum of top 3 -- $runningTotal"
rm tmp.txt