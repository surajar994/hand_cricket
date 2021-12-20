#!/bin/bash

function toss(){
		ret=0
	com_num=$((1 + $RANDOM % 6))
	while :
	do
	read -p "Odd or Even (o/e):" usr_chc
	if [[ ${usr_chc^^} != O && ${usr_chc^^} != E ]]
	then
			echo "Invalid Entry. Try again!!!"
	else
		break
	fi
	done

	while :
	do
	read -p "Your number (1-6):" usr_num
	if [[ $usr_chc -gt 6 && $user_chc -lt 0 ]]
	then
		echo "Invalid Entry. Try again!!!"
	else
		break
	fi
	done
	
if [[ ${usr_chc^^} == O || ${usr_chc^^} == E  ]]
then
	if [[ $usr_num -lt 7 ]]
	then
		toss=$(( $com_num + $usr_num))
		toss_flg=$(($toss % 2))
		[[ ${usr_chc^^} == E ]] && chc_flg=0 || chc_flg=1
		[[ $toss_flg == $chc_flg ]] && ret=0 || ret=1
	fi
fi
echo "Computer chose $com_num"
return $ret
}
