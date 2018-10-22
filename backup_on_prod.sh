#!/usr/bin/env bash
#
# Usage 1: ./backup_on_prod.sh abc /var/www/html/abc
# Usage 2: ./backup_on_prod.sh abc "/var/www/html/abc /var/www/proj1/mysql"
# Usage 3: ./backup_on_prod.sh abc "$(cat filelist)"

show_usage()
{
  echo
  echo Usage: ./backup_on_prod.sh short_description \"file_to_save_1 file_to_save_2\"
  echo 
  echo Examples:
  echo
  echo Usage 1: ./backup_on_prod.sh abc /var/www/html/abc
  echo Usage 2: ./backup_on_prod.sh abc \"/var/www/html/abc /var/www/proj1/mysql\"
  echo Usage 3: ./backup_on_prod.sh abc \"\$\(cat filelist\)\"
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

if [ $# -gt 2 ]; then
  echo ""
  echo "ERROR: Too many arguments"
  show_usage
  exit 1
fi

description="$1"
files_to_backup="$2"
#echo "Backing up files $files_to_backup"
#echo


mybackupname="archive-$HOSTNAME-$description-$(date +%Y-%m-%d_%H%M%S).tar.gz"
echo "Creating backup $mybackupname"
echo
#exit 0

# What to backup on server
backup_files=$files_to_backup


# Where to backup to
username="jflemming"
dest="/home/$username/backup"

# Record start time by epoch second
start=$(date '+%s')

# List of excludes in a bash array, for easier reading.
excludes=(--exclude=./$mybackupname)
excludes+=(--exclude=/var/www/html/dead_stuff)
excludes+=(--exclude=*junk*)
excludes+=(--exclude=logs)
excludes+=(--exclude=*.log)
excludes+=(--exclude=*.log.*)
excludes+=(--exclude=abisfiles)
excludes+=(--exclude=*.txt)
excludes+=(--exclude=*.txt.*)
excludes+=(--exclude=tmp)
excludes+=(--exclude=/var/www/html/abc/web/setup)

# Testing excludes, print any matches to confirm we aren't
# excluding something important
for path in $backup_files
do
  if [[ -d $path ]]; then
    echo "$path is a directory"
    for i in "${excludes[@]}"
    do
      find $path -name "$i"
    done
  elif [[ -f $path ]]; then
    for i in "${excludes[@]}"
    do
      #echo "$path is a file"
      [[ $path =~ $i ]] && echo "matched" || echo "did not match"
      #[[ $path =~ $i ]] && echo "$path is being excluded"
    done
  fi
done

#echo tar -czvf "$mybackupname" "${excludes[@]}" $backup_files
if ! tar -czvf "$mybackupname" "${excludes[@]}" $backup_files; then
  status="tar failed"
elif ! mv "$mybackupname" "$dest/" ; then
  status="mv failed"
fi

if [ -e "$dest/$mybackupname" ]; then
  status="success: size=$(stat -c%s "$dest/$mybackupname") duration=$((`date '+%s'` - $start))"
  chown $username:$username $dest/$mybackupname
  chmod 700 $dest/$mybackupname
fi

echo $status
echo `pwd`
echo `ls -l $dest/$mybackupname`


