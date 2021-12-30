#!/bin/bash

loc="/data/data/com.termux/files/home/storage/scripts/handcricket/"
pfl="${loc}profile.txt"
rcd="${loc}records.txt"

function get_mtch_cnt(){
    mtchs=$(tail -1 $rcd | awk -F'|' '{print $1}')
    sed -i s/Matches=.*/Matches=$mtchs/g $pfl
}

function get_runs(){
    tot_runs=0
    wins=0
    lose=0
    tie=0
    cent=0
    hf_cent=0
    fours=0
    sixes=0
    not_out=0
    hgh_scr=0

    while read line
    do
        inn=$(echo $line | awk -F'|' '{print $2}')
        runs=($(echo "$inn" | awk -F':' '{print $2}'))
        inn_runs=0

        if [[ $inn == "You* "* ]]
        then
            ((not_out++))
        fi

        for run in ${runs[@]}
        do
            inn_runs=$(($inn_runs + $run))
            if [[ $run == 4 ]]
            then
                ((++fours))
            elif [[ $run == 6 ]]
            then
                ((++sixes))
            fi
        done

        [[ $inn_runs -gt $hgh_scr ]] && hgh_scr=$inn_runs
        tot_runs=$(($tot_runs + $inn_runs))

        if [[ $inn_runs -ge 100 ]]
        then
            ((cent++))
        elif [[ $inn_runs -ge 50 ]]
        then
            ((hf_cent++))
        fi

        res=$(echo $line | awk -F'|' '{print $4}')
        if [[ $res == "You won"* ]]
        then
            ((wins++))
        elif [[ $res == "Com won"* ]]
        then
            ((lose++))
        elif [[ $res == "You lose"* ]]
        then
            ((lose++))
        elif [[ $res == "Com lose"* ]]
        then
            ((wins++))
        elif [[ $res == *"tied"* ]]
        then
            ((tie++))
        fi 
    done < $rcd

    sed -i s/Runs=.*/Runs=$tot_runs/g $pfl
    sed -i s/Wins=.*/Wins=$wins/g $pfl
    sed -i s/Loses=.*/Loses=$lose/g $pfl
    sed -i s/Tied=.*/Tied=$tie/g $pfl

    sed -i s/Centuries=.*/Centuries=$cent/g $pfl
    sed -i s/"Half Centuries=.*"/"Half Centuries=$hf_cent"/g $pfl

    sed -i s/Fours=.*/Fours=$fours/g $pfl
    sed -i s/Sixes=.*/Sixes=$sixes/g $pfl

    avg=$(($tot_runs / $(($mtchs - $not_out)) ))
    
    sed -i s/"Batting average=.*"/"Batting average=$avg"/g $pfl
    sed -i s/"High Score=.*"/"High Score=$hgh_scr"/g $pfl
}

function update_profile(){
get_mtch_cnt
get_runs
}


