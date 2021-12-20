#!/bin/bash

. ./validate.sh

function bat(){
    out=0
    inn=$1

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
            if [[ $usr_bat == $com_bowl ]]
            then
               echo "Com bowl : "$com_bowl 
                echo "OUT!!!"

                echo "Your score : "$usr_runs
                com_trgt=$(($usr_runs + 1))
                out=1
            else
                usr_runs=$(($usr_runs + $usr_bat))
                echo "Com bowl : "$com_bowl
                if [[ $inn == 2 ]]
                then
                    if [[ $usr_runs -ge $usr_trgt ]]
                    then
                        echo "You won"
                        break
                    fi
                fi
            fi
            break
        fi
    done
done
}

