#!/bin/env bash
# Save logfile with timestamp and create new blank logfile
#
# usage: ./savelog.sh <filename>
#
show_usage()
{
  echo
  echo Usage: ./savelog.sh \<filename\>
  echo
}

if [ $# -eq 0 ]; then
  echo ""
  echo "ERROR: No agruments provided"
  show_usage
  exit 1
fi


TIMESTAMP=`date +%Y%m%d_%k%M`

mv "$1" "$1-$TIMESTAMP"
touch "$1"
chmod 640 "$1"
