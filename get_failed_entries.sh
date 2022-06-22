#!/bin/bash
# Author: Ankit Grover @agrover112
# 20th May 2022

file=$1

function dir_exec()
{

  for i in $direc/*;
  do
    echo $var
    #export var
    echo "Finding lexicon entries file:"$i;
    exit 1;
    #sed "s/C++/C plus plus/" w1_1.txt > w_temp.text
    sudo bash temp_q.sh $i;
    sudo cp data/local/dict_nosp/g2p/log/g2p.*.log ./inspect/g2p.1.log
    sudo grep -o '".*"' ./inspect/g2p.1.log | sed -e 's/^"/ /' -e 's/"$/ /' >>failed_entries.txt;
    #echo $?
    echo "Combining lexicons"
    sudo cat data/local/dict_nosp/lexicon_raw_nosil_our.txt>>combined_lexicon
    #echo "Adding_new_lexicon\n">>combined_scert_lexicon
    ((++ var))

  done

  sudo cat combined_lexicon | sort -u | uniq >./txt_lexicon.txt


}



function file_exec()
{

    i=$file
    echo $i
    echo $var
    echo "Finding lexicon entries file:"$i;
    #sed "s/C++/C plus plus/" w1_1.txt > w_temp.text
    sudo bash temp_q.sh $i;
    sudo cp data/local/dict_nosp/g2p/log/g2p.*.log ./inspect/g2p.1.log
    sudo grep -o '".*"' ./inspect/g2p.1.log | sed -e 's/^"/ /' -e 's/"$/ /' >>failed_entries.txt;
    #echo $?
    echo "Combining lexicons"
    sudo cat data/local/dict_nosp/lexicon_raw_nosil_our.txt>file_lexicon
    sudo cat file_lexicon | sort -u | uniq >./file_lexicon.txt
    rm -f file_lexicon

}
   



function basic_parser()
{
  stage=${stage:-1}
  njobs=${njobs:-4}
  name=${name:-agrover112}
  direc=${direc:-false}
  file=${file:-false}

	while [ $# -gt 0 ]; do

		if [[ $1 == *"--"*  ]]; then
				param="${1/--/}"
				#echo $param
				declare $param="$2"
				# echo $1 $2 // Optional to see the parameter:value result
		elif  [[ $1 == *"-"*  ]]; then
			param="${1/-/}"
				#echo $param
				declare $param="$2"
		fi

		shift
	done

	echo  "Args read",$name $njobs $stage $direc $file
  export file

}

#[[ -d $dir ]] || { echo "Directory $dir does not exist" && exit 1; } && { echo "Directory $dir exists"; }




function main ()
{
  #stage=${stage:-1}
  #njobs=${njobs:-4}
  direc=${direc:-0}
  file=${file:-0}

	while [ $# -gt 0 ]; do

		if [[ $1 == *"--"*  ]]; then
				param="${1/--/}"
				#echo $param
				declare $param="$2"
				#echo $1 $2 // Optional to see the parameter:value result
		elif  [[ $1 == *"-"*  ]]; then
			param="${1/-/}"
				declare $param="$2"
		fi

		shift
	done


#[  -d $direc ] && file=""
#[  -d $file ] && direc="" 
#echo "Direc :"$direc "File "$file $stage $njobs
[ ! -d $file ] && { file_exec; } || { dir_exec;}
#echo $file

}

main $@


## FIX PARSER SCRIPT
