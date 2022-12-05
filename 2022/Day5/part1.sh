#!/bin/bash
grep move input.txt > instructions.txt
grep -v move input.txt > crates.txt
stack1="Z N"
stack2="M C D"
stack3="P"
# stack1="ZPMHR"
# stack2="PCJB"
# stack3="SNHGLCD"
stack4="FTMDQSRL"
stack5="FSPQBTZM"
stack6="TFSZBG"
stack7="NRV"
stack8="PGLTDVCM"
stack9="WQNJFML"


for i in {1..9}; do
    stack="stack${i}"
    echo ${!stack} > stack$i
done

cat instructions.txt | while read i; do
    howMany=$(echo $i | awk '{print $2}')
    from=$(echo $i | awk '{print $4}')
    to=$(echo $i | awk '{print $6}')
    current=1
    while [ $current -le $howMany ]; do
        last=$(cat stack$from | awk '{print $NF}')
        temp=`cat stack$to`
        temp="$temp $last"
        echo $temp > stack$to
        temp=$(rev stack1 | cut -d ' ' -f 2- | rev)
        echo $temp > stack$from
        # echo ${!stack} | awk 'NF{NF==};1'
        # echo ${!stack}
        current=$(expr $current + 1 )
    done
done

for i in {1..9}; do
    rm -f stack$i
done