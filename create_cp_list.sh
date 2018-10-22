#!/usr/bin/env bash
export TIMESTAMP=`date +_%Y-%m%d-%H%Mh%S`

app_name='revs'

dir1_base='/home/enabler02/workspace2/REVS_QA_Changes/revs1.0'
dir2_base='/home/enabler02/workspace2/REVS_Rename2'

#dir1_base='/var/www/html/fspki'
#dir1_base='/var/www/html/fsa1.2'


file_copy="cp_${app_name}_changes.sh"


echo "#!/usr/bin/env bash" > $file_copy 
echo "## " $TIMESTMAP >> $file_copy 

#for i in $(cat fs_updates_edited.list)
for i in $(find "$dir1_base" -type f)
do 
  if [[ $i =~ ^fspki\/.* ]]
  then
    #echo ${i#fspki}
    echo 
    echo cp $i   ${dir1_base}${i#fspki} | tee -a $file_copy
  elif [[ $i =~ ^fsa\/.* ]]
  then
    #echo ${i#fsa}
    echo
    echo cp $i   ${dir1_base}${i#fsa} | tee -a $file_copy
  fi
done
