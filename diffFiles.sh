#!/bin/bash
#
#
# Diff files with a label to the files in your 
# current clearcase view
#
# 

export TIMESTAMP=`date +_%Y-%m%d-%H%Mh%S`


if [ ! $1 ]
    then
        echo Please supply a clearcase label to ue for diff
        exit    
    else
        echo Diff\'ing current view with label"("$1")" | tee ./.diff_cview_${1}_${TIMESTAMP}.txt
fi

export DIFF_FILE=./.diff_cview_${1}_${TIMESTAMP}.txt

for FILE in `ls *.h *.cpp`
do
    if [ `diff --brief $FILE $FILE@@/$1 | sed s/' '/_/g` ]
    then
        echo "" | tee -a $DIFF_FILE
        echo +++++++++++++++++++++++++++++++++++++++++++++++++++ | tee -a $DIFF_FILE
        echo vsdiff $FILE " " $FILE@@/$1 | tee -a $DIFF_FILE    
        echo "> $FILE@@/$1" | tee -a $DIFF_FILE
        echo "< $FILE" | tee -a $DIFF_FILE
        echo "" | tee -a $DIFF_FILE
        echo _ | tee -a  $DIFF_FILE
        echo "" | tee -a  $DIFF_FILE
        diff -b $FILE $FILE@@/$1 | tee -a $DIFF_FILE
    fi

done;

echo View file ...   $DIFF_FILE   for results
exit

