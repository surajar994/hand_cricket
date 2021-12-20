#!/bin/bash

. ./validate.sh

function bowl(){
    wkt=0
    inn=$1

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
             echo "Com bat : "$com_bat
            if [[ $usr_bowl == $com_bat ]]
            then
                echo "OUT!!!"

                echo "Com score : "$com_runs
                wkt=1
                usr_trgt=$(($com_runs + 1 ))
            else
                com_runs=$(($com_runs + $com_bat))
                if [[ $inn == 2 ]]
                then
                    if [[ $com_runs -ge $com_trgt ]]
                    then
                        echo "Com won"
                        break
                    fi
                fi
            fi
            break
        fi
    done
done
}
