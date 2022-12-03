#!/bin/bash
runningTotal=0
addStuff () {
    runningTotal=$(expr $runningTotal + $choice + $outcome)
}
cat strategyGuide.txt | while read line; do
    case $line in
    'A X')
        choice="1"
        outcome="3"
        ;;
    'A Y')
        choice="2"
        outcome="6"
        ;;
    'A Z')
        choice="3"
        outcome="0"
        ;;
    'B X')
        choice="1"
        outcome="0"
        ;;
    'B Y')
        choice="2"
        outcome="3"
        ;;
    'B Z')
        choice="3"
        outcome="6"
        ;;
    'C X')
        choice="1"
        outcome="6"
        ;;
    'C Y')
        choice="2"
        outcome="0"
        ;;
    'C Z')
        choice="3"
        outcome="3"
        ;;
    esac
    addStuff
    echo "Total -- $runningTotal"
done