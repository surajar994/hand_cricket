#!/bin/bash

. ./validate.sh
. ./update_profile.sh

function bat(){
    count=0
    out=0
    inn=$1
    if [[ $inn == 1 ]]
    then
        hstry="Your batting :"
    else
        hstry="Target : $usr_trgt\nYour batting :"
    fi

   while [[ $out == 0 ]]; do
    while :
    do     
        com_bowl=$(($RANDOM % 7))
        read -p "Runs : " usr_bat
        validate $usr_bat
        if [[ $? != 0 ]]
        then
            echo "Invalid Entry. Reball"
        else
            ((++count))
            if [[ $(($count %  6)) == 0 ]]
            then
                hstry="$hstry $usr_bat\nYour batting :"
            else
                hstry="$hstry $usr_bat"
            fi

            clear
            echo -e "$hstry"
            if [[ $usr_bat == $com_bowl ]]
            then
               echo "Com bowl : "$com_bowl 
                echo "OUT!!!"

                echo "Your score : $usr_runs runs in $count balls"
                com_trgt=$(($usr_runs + 1))
                out=1
                hstry="Batting :$hstry $'\n'Your score :$usr_runs"
            else
                usr_runs=$(($usr_runs + $usr_bat))
                usr_inn[${#usr_inn[@]}]=$usr_bat
                echo "Com bowl : "$com_bowl
                if [[ $inn == 2 ]]
                then
                    if [[ $usr_runs -ge $usr_trgt ]]
                    then
                        echo "You won"
                        winner="You won"
                        echo "$this_mtch|You* :${usr_inn[@]}|Com : ${com_inn[@]}|$winner" >> $rcd
                        update_profile
                        exit
                    fi
                fi
            fi
            break
        fi
    done
done
}

