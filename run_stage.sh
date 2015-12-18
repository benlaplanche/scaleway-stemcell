#!/usr/bin/env bash


for stage in $1 
do 
	if [[ -f "/stemcell_builder/stages/$stage/config.sh" ]] 
	then
		echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		echo "FOUND CONFIG"
		"/stemcell_builder/stages/$stage/config.sh" "$3"
	fi	
	"/stemcell_builder/stages/$stage/apply.sh" "$2"
	echo "--------------------"
	echo "--------------------"
done
