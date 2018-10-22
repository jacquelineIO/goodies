#!/usr/bin/env bash
# 
# Filename: rm_win_files.sh
#
# Usage: rm_win_files.sh filename
#

FILENAME="$1"

if [ -e $FILENAME ]; then
	for i in $(cat $FILENAME)
	do
	  echo "remove $i ..."
	  #rm `cygpath "$i"`
	  echo rm `cygpath "$i"`
	done
else
	echo "FILE: $FILENAME does not exist"
fi
