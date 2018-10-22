!/usr/bin/env bash
export TIMESTAMP=`date +_%Y-%m%d-%H%Mh%S`

project='revs'
#revs_base='/home/enabler02/workspace4/REVS'
revs_base='/var/www/html/revs1.2'
fsa_base='/cygdrive/c/bit9prog/dev/workspace/fsapkitest'

export diff_file=./${project}_diff_${TIMESTAMP}.diff

echo "## Run diff with $revs_base" > $diff_file
echo "## " $TIMESTMAP >> $diff_file

## Check if file is in fspki or fsa, and
## then run the diff
#for i in $(cat fs_updates_edited.list)
#do
#  if [[ $i =~ ^fspki\/.* ]]
#  then
#    echo >> $diff_file
#    echo diff $i ${revs_base}${i#fspki} >> $diff_file
#    diff -sb $i ${revs_base}${i#fspki} >> $diff_file
#  elif [[ $i =~ ^fsa\/.* ]]
#  then
#    echo >> $diff_file
#    echo diff $i ${fsa_base}${i#fsa} >> $diff_file
#    diff -sb $i ${fsa_base}${i#fsa} >> $diff_file
#  fi
#done

for i in $(cat REVS_1.2_v09_updates.lis)
do
  echo $i
  if [[ $i =~ ^REVS_1.2_v09\/.* ]]
  then
    echo >> $diff_file
    echo diff $i ${revs_base}${i#REVS_1.2_v09} >> $diff_file
    diff -sb $i ${revs_base}${i#REVS_1.2_v09} >> $diff_file
  elif [[ $i =~ ^fsa\/.* ]]
  then
    echo >> $diff_file
    echo diff $i ${fsa_base}${i#fsa} >> $diff_file
    diff -sb $i ${fsa_base}${i#fsa} >> $diff_file
  fi
done
