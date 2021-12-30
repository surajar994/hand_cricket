#!/bin/bash 

. ./bat.sh
. ./ball.sh
. ./toss.sh
. ./chck_winner.sh
. ./record_maintenance.sh
. ./update_profile.sh
side=( bat bowl )
usr_trgt=1
com_runs=0
com_trgt=1
usr_runs=0
usr_inn=()
com_inn=()
winner=""
rcd="/data/data/com.termux/files/home/storage/scripts/handcricket/records.txt"

get_mtch_no
prev_mtch_no=$?
this_mtch=$(($prev_mtch_no + 1))
toss
if [[ $? == 0 ]] 
then
    end=0
    while [[ $end == 0 ]];
	do
		read -p "Bat or Bowl (ba/bo) :" usr_chc
		if [[ $usr_chc == ba ]]
		then
				usr_inn1=${side[0]}
				com_inn1=${side[1]}
				bat 1
				echo "Com needs $(($com_trgt)) runs to win"
				bowl 2
                chck_winner $com_trgt $com_runs Com 
            end=1
		elif [[ $usr_chc == bo ]]
		then
				bowl 1
				echo "You need $(($usr_trgt)) runs to win"
				bat 2
                chck_winner $usr_trgt $usr_runs You
            end=1
		else
				echo "Invalid entry"
		fi
	done
				
else
		com_side=${side[$(($RANDOM % 2))]}
		echo "And chose to $com_side"
		if [[ $com_side == bat ]]
		then
				bowl 1
				echo "You need $(($usr_trgt)) runs to win"
				bat 2
				chck_winner $usr_trgt $usr_runs You
		else
				bat 1
				echo "Com needs $(($com_trgt)) runs to win"
                bowl 2
				chck_winner $com_trgt $com_runs Com
		fi
fi
echo "$this_mtch|You :${usr_inn[@]}|Com : ${com_inn[@]}|$winner" >> $rcd

update_profile
