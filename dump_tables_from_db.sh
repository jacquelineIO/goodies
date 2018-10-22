#!/usr/bin/env bash

db_user="user"
db_pass="password\$"

show_usage()
{
  echo
  echo Usage: ./dump_tables_from_db.sh \<databasename\> \<filelist\>
  echo
}


if [ $# -eq 0 ]; then
  echo ""
  echo "ERROR: No agruments provided"
  show_usage
  exit 1
fi

if [ $# -lt 2 ]; then
  echo ""
  echo "ERROR: Expecting two arguments"
  show_usage
  exit 1
fi

database="$1"
tablelist="$2"
directory="./db_backup/${database}_$(date +%Y-%m-%d_%H%M%S)"

mkdir -p $directory
if [[ ! -d $directory ]]; then
  echo
  echo Could not create directory $directory
  echo
  exit
fi


# Dump schema for one db only
mysqldump --add-drop-table  --no-data --triggers --user=$db_user --password=$db_pass $database  > $directory/${database}_schema_no_data.sql

# Dump the routines only
mysqldump --routines --no-create-info --no-data --no-create-db --skip-opt --user=$db_user --password=$db_pass $database > $directory/${database}_routines.sql

# Dump applicaiton data tables
while read table
do
  sql_filename="${directory}/${table}.sql"
  #echo "mysqldump -add-drop-table -u $db_user --password=$db_pass $database $table"
  mysqldump --add-drop-table --user=$db_user --password=$db_pass $database $table > $sql_filename
done <$tablelist

pwd
#ls -l $directory
echo
echo Finished dumping tables from $tablelist to $directory
echo

echo
echo Tar up directory ...
echo
tar -czvf ${directory}.tar.gz $directory
ls -l ${directory}.tar.gz

echo
echo Script complete, exiting
echo
