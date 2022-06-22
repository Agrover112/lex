#!/bin/bash

function create_vocab()
{
  words_file=$1  
  sed  -e 's/\r/ /g' -e 's/\“/"/g' -e 's/\”/"/g' $words_file >our_vocab_temp.txt
  sed -E -e "s/([[:alpha:]]['’][[:alpha:]])|['‘’]/\\1/g" -e 's/[][()>?,;.!\…:]|\′|…/ /g' our_vocab_temp.txt  | sed -e 's/\"/ /g' -e  's/\"/ /g' | tr ' ' '\n' | tr 'a-z' 'A-Z' |  sort | uniq > our_vocab.txt #  tr ' ' '\n' | sed -e "s/\’/'/g"|  sed "s/\…/ /g"  |  tr '.' ' ' |  sed -e "s/\[/ /g" -e "s/\]/ /g" -e 's/(/ /g' -e "s/)/ /g" |  sort -u |  tr 'a-z' 'A-Z' >our_vocab.txt
  echo -n "$PWD"/our_vocab.txt
  #sed -i -e 's/\r//g'
}

#words_file=$1


function main()
{
    if [ $# -ne 3 ]; then
      echo "Usage: $0 [options] <db1-path> <db2-path> <text-file> "
      echo "e.g.: find_oov.sh /path/cmudict.plain /path/librispeech-vocab.txt our_words.txt"
      exit 1
    fi    
    #vocab=$(create_vocab $1)
    #array=($PWD"/data/local/dict_nosp/cmudict.0.7a.plain" $PWD"/data/local/lm/librispeech-vocab.txt")
    #local var=0
    #for i in "${array[@]}"
    #do
    #  echo $i $var 
    #  awk 'NR==FNR{a[$1] = 1; next} !($1 in a)' $i $vocab  | sort  > not_db_n.txt ;
    #  cat not_db_n.txt | uniq > not_db.txt
    #  vocab="$PWD"/not_db.txt;
    #  ((++ var));
    #done

    db1=$1
    db2=$2
    #db1="../librispeech/s5/data/local/dict_nosp/cmudict.0.7a.plain"
    #db2="../librispeech/s5/data/local/lm/librispeech-vocab.txt"
    vocab=$(create_vocab $3)

    awk 'NR==FNR{a[$1] = 1; next} !($1 in a)' $db1 $vocab  |\
        sort > not_db1.txt

    not_cmu=not_db1.txt
    awk 'NR==FNR{a[$1] = 1; next} !($1 in a)' $db2  $not_cmu |\
        sort > not_both1.txt

}

main "$@"

