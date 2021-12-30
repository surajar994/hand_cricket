#!/bin/bash

. ./validate.sh
. ./update_profile.sh

function bowl(){
    count=0
    wkt=0
    inn=$1
    if [[ $inn == 1 ]]
    then
        hstry="Com Batting :"
    else
        hstry="Target $com_trgt\nCom Batting :"
    fi

    while [[ $wkt == 0 ]]
    do
     while :
       do
        com_bat=$(($RANDOM % 7))
        read -p "Bowl : " usr_bowl
        validate $usr_bowl
        if [[ $? != 0 ]]
        then
            echo "Invalid Ball. Reball"
        else
            ((++count))
            if [[ $(($count % 6)) == 0 ]]
            then
                hstry="$hstry $com_bat\nCom Batting :"
            else
            hstry="$hstry $com_bat"
            fi
            clear
            echo -e $hstry
            if [[ $usr_bowl == $com_bat ]]
            then
                echo "OUT!!!"

                echo "Com score : $com_runs runs in $count balls"
                wkt=1
                usr_trgt=$(($com_runs + 1 ))
            else
                com_runs=$(($com_runs + $com_bat))
                com_inn[${#com_inn[@]}]=$com_bat
                if [[ $inn == 2 ]]
                then
                    if [[ $com_runs -ge $com_trgt ]]
                    then
                        echo "Com won"
                        winner="Com won"
                        echo "$this_mtch|You :${usr_inn[@]}|Com : ${com_inn[@]}|$winner" >> $rcd
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
