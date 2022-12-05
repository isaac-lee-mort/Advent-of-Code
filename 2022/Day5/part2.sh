#!/bin/bash
grep move input.txt > instructions.txt
grep -v move input.txt > crates.txt
# ## Example Vars
# stack1="Z N"
# stack2="M C D"
# stack3="P "
## Actual Vars
stack1="Z P M H R " 
stack2="P C J B " 
stack3="S N H G L C D "
stack4="F T M D Q S R L "
stack5="F S P Q B T Z M "
stack6="T F S Z B G " 
stack7="N R V " 
stack8="P G L T D V C M"
stack9="W Q N J F M L "


for i in {1..9}; do
    ## Bottom of line is top of stack
    stack="stack${i}"
    echo ${!stack} | tr " " "\n" > stack$i
done

cat instructions.txt | while read i; do
    howMany=$(echo $i | awk '{print $2}')
    from=$(echo $i | awk '{print $4}')
    to=$(echo $i | awk '{print $6}')
    current=1
    > holdingArea
    while [ $current -le $howMany ]; do
        last=`tail -n1 stack$from`
        echo $last >> holdingArea
        sed -i '' -e '$ d' stack$from
        current=$(expr $current + 1 )
    done
    tac holdingArea >> stack$to
done

for i in {1..9}; do
    top=`tail -n1 stack$i`
    output="$output$top"
    rm -f stack$i
done
rm -f holdingArea crates.txt instructions.txt
echo $output