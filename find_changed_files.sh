#!/usr/bin/env bash
#
# Must create a file to use as a timestamp. E.g. "touch newer_than_this"
#

show_usage()
{
  echo
  echo Usage: ./find_changed_files.sh \<newer_than_this#\>
  echo
}


if [ $# -eq 0 ]; then
  echo ""
  echo "ERROR: No agruments provided"
  show_usage
  exit 1
fi

newerthanthis="$1"

datestamp=$(date +%Y-%m-%d_%H%M%S)
tarname="XXX_changes_on_QA_${datestamp}.tgz"
changed_files=($(find . -newer /var/www/html/${newerthanthis} -type f| grep -v "\.cache" | grep -v "\.log" | grep -v "\.tgz"))

# List of excludes in a bash array, for easier reading.
excludes=(--exclude=./xxx1.0)
excludes+=(--exclude=./xxx1.1)
excludes+=(--exclude=./PHPReports1.0)
excludes+=(--exclude=./PHPReports1.1)
excludes+=(--exclude=xxx_poc1.1_20170731.tgz)

tar -cvzf $tarname "${excludes[@]}" "${changed_files[@]}"

echo
ls -l $tarname
echo
echo Ready for copy $tarname
echo
echo
