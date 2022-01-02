#!/bin/bash

loc=$(dirname $0)
pfl="${loc}/profile.txt"
rcd="${loc}/records.txt"

function get_mtch_cnt(){
	mtchs=$(echo $data | awk -F'|' '{print $1}')
    	((++mtchs))
	sed -i s/Matches=.*/Matches=$mtchs/g $pfl
}

function get_runs(){
	tot_runs=$(grep "Runs" $pfl | awk -F'=' '{print $2}')
    wins=$(grep "Wins" $pfl | awk -F'=' '{print $2}')
    lose=$(grep "Loses" $pfl | awk -F'=' '{print $2}')
    tie=$(grep "Tied" $pfl | awk -F'=' '{print $2}')
    cent=$(grep "100s" $pfl | awk -F'=' '{print $2}')
    hf_cent=$(grep "50s" $pfl | awk -F'=' '{print $2}')
    fours=$(grep "Fours" $pfl | awk -F'=' '{print $2}')
    sixes=$(grep "Sixes" $pfl | awk -F'=' '{print $2}')
    not_out=$(grep "Not Outs" $pfl | awk -F'=' '{print $2}')
    hgh_scr=$(grep "High Score" $pfl | awk -F'=' '{print $2}')

        inn=$(echo $data | awk -F'|' '{print $2}')
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

        res=$(echo $data | awk -F'|' '{print $4}')
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

    sed -i s/Runs=.*/Runs=$tot_runs/g $pfl
    sed -i s/Wins=.*/Wins=$wins/g $pfl
    sed -i s/Loses=.*/Loses=$lose/g $pfl
    sed -i s/Tied=.*/Tied=$tie/g $pfl

    sed -i s/100s=.*/100s=$cent/g $pfl
    sed -i s/"50s=.*"/"50s=${hf_cent}"/g $pfl

    sed -i s/Fours=.*/Fours=$fours/g $pfl
    sed -i s/Sixes=.*/Sixes=$sixes/g $pfl

    avg=$(($tot_runs / $(($mtchs - $not_out)) ))
    
    sed -i s/"Batting average=.*"/"Batting average=$avg"/g $pfl
    sed -i s/"High Score=.*"/"High Score=$hgh_scr"/g $pfl
}

function update_profile(){
data=$@
get_mtch_cnt
get_runs
}
