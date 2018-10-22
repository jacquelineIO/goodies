#!/usr/bin/env bash
export TIMESTAMP=`date +_%Y-%m%d-%H%Mh%S`

fspki_base='/var/www/html/fspki'
fsa_base='/var/www/html/fsa'

export diff_file=./fspki_diff_${TIMESTAMP}.diff

#echo "#!/usr/bin/evn bash"
echo "## " $TIMESTMAP > $diff_file

for i in $(cat fs_updates_edited.list)
do 
  if [[ $i =~ ^fspki\/.* ]]
  then
    echo >> $diff_file
    echo diff $i ${fspki_base}${i#fspki} >> $diff_file
    diff -sb $i ${fspki_base}${i#fspki} >> $diff_file
  elif [[ $i =~ ^fsa\/.* ]]
  then
    echo >> $diff_file
    echo diff $i ${fsa_base}${i#fsa} >> $diff_file
    diff -sb $i ${fsa_base}${i#fsa} >> $diff_file
  fi
done
