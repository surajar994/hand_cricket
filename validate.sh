#!/bin/bash

function validate(){
    entry=$1
    ret=0
    
    [[ $entry -lt 0 ]] && ret=1
    [[ $entry -gt 6 ]] && ret=1 
    [[ ! $entry =~ ^[0-9]+$ ]] && ret=1
    return $ret
}
