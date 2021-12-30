#!/bin/bash

function get_mtch_no(){
    rcd="/data/data/com.termux/files/home/storage/scripts/handcricket/records.txt"
    match=$(tail -1 $rcd | awk -F'|' '{print $1}')
    return $match
}
