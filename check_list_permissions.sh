#!/usr/bin/env bash
export TIMESTAMP=`date +_%Y-%m%d-%H%Mh%S`

#revs_base='/home/enabler02/workspace4/REVS'
revs_base='/var/www/html/revs1.2'
fsa_base='/cygdrive/c/bit9prog/dev/workspace/fsapkitest'


project='revs'
file_copy="check_permissions_${project}_changes.sh"


echo "#!/usr/bin/env bash" > $file_copy
echo "## " $TIMESTMAP >> $file_copy


for i in $(cat REVS_1.2_v05_updates.lis)
do
  if [[ $i =~ ^REVS_1.2_v05\/.* ]]
  then
    #echo ${i#fspki}
    echo
    echo ls -l ${revs_base}${i#REVS_1.2_v05} | tee -a $file_copy
  elif [[ $i =~ ^fsa\/.* ]]
  then
    #echo ${i#fsa}
    echo
    echo ls -l  ${fsa_base}${i#fsa} | tee -a $file_copy
  fi
done
