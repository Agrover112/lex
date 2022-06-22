#!/bin/bash

. ./path.sh
. ./cmd.sh
#sed -e "s/\[/ /g" -e "s/\]/ /g" -e 's/(/ /g' -e "s/)/ /g" 


#cat $1 | sed "s/^'\(.*\)\'$/\1/" |  sed -e "s/\’/'/g" -e  "s/\‘/'/g" | sed -e "s/^'/ /g" -e "s/'$/ /g" | sed "s/\…/ /g" | tr '>' ' ' | tr '?' ' ' | tr ',' ' ' | tr ';' ' ' | tr '.' ' ' | tr '!' ' ' | tr '′' ' ' | tr ':' ' ' | sed -e "s/\[/ /g" -e "s/\]/ /g" -e 's/(/ /g' -e "s/)/ /g" | tr ' ' '\n' | sort -u | uniq | tr 'a-z' 'A-Z' >our_vocab.txt

# not required as of now sed  -e 's/\r/ /g' -e 's/\“/"/g' -e 's/\”/"/g' $1 >our_vocab_temp.txt
#not required as of now sed -E -e "s/([[:alpha:]]['’][[:alpha:]])|['‘’]/\\1/g" -e 's/[][()>?,;.!\…:]|\′|…/ /g' our_vocab_temp.txt  | sed -e 's/\"/ /g' -e  's/\"/ /g' | tr ' ' '\n' | tr 'a-z' 'A-Z' |  sort -u | uniq > our_vocab.txt #  tr ' ' '\n' | sed -e "s/\’/'/g"|  sed "s/\…/ /g"  |  tr '.' ' ' |  sed -e "s/\[/ /g" -e "s/\]/ /g" -e 's/(/ /g' -e "s/)/ /g" |  sort -u |  tr 'a-z' 'A-Z' >our_vocab.txt
#sed -i -e 's/\r//g'


bash dict.sh --stage 1  --nj 40 --cmd "$train_cmd" \
	data/local/lm data/local/lm data/local/dict_nosp our_vocab.txt

#cat $our_vocab >./inspect/$var.txt
