#!/bin/bash
runningTotal=0
addStuff () {
    runningTotal=$(expr $runningTotal + $choice + $outcome)
}
cat strategyGuide.txt | while read line; do
    case $line in
    'A X')
        choice="3"
        outcome="0"
        ;;
    'A Y')
        choice="1"
        outcome="3"
        ;;
    'A Z')
        choice="2"
        outcome="6"
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
        choice="2"
        outcome="0"
        ;;
    'C Y')
        choice="3"
        outcome="3"
        ;;
    'C Z')
        choice="1"
        outcome="6"
        ;;
    esac
    addStuff
    echo "Total -- $runningTotal"
done