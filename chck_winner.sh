#!/bin/bash

function chck_winner(){
    
 trgt=$1
 runs=$2
 side=$3
    
 if [[ $(($trgt -1)) -gt $runs ]]
then
		echo "$side lose by $(($trgt - $runs -1)) runs"
		winner="$side lose by $(($trgt - $runs -1)) runs"
else
	if [[ $(($trgt - 1))  == $runs ]]
	then
		echo "Match tied"
        winner="Match tied"
	else
		echo "$side won the match"
	fi
fi

}
