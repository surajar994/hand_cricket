#!/bin/bash

function get_mtch_no(){
	loc=$(dirname $0)
    	rcd="${loc}/records.txt"
    	match=$(tail -1 $rcd | awk -F'|' '{print $1}')
    	return $match
}
