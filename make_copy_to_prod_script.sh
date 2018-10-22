#!/usr/bin/env bash
#
# Useage: make_copy_to_prod_script.sh
#
# Description: Setup the STAGING_DIR and STAGING_PATH to point to the source
#   directory where the files pulled from RTC are located.
#
# Variables: 
#   STAGING_DIR: Directory where source files to be copied to dev or production
#     server live.
#
#   STAGING_PATH: Path leading to the STAGING_DIR
#
#   DEST_DIRS: The absolute pathes where the source files will be copied to
#
#   DEST_APP: The folder name of the application that the files will be copied to
#
# Help:
#   The user running this script should verify and/or update the STAGING_DIR and
#     the DEST_APP names
#
# TODO: if source file not found, add marker to file
#
# Author: Jacqueline Flemming
# Date:   June 5th, 2015        - initial version
#

STAGING_DIR="CR_25889"
STAGING_PATH="/var/staging/"
# /var/www/html or /var/proj1
DEST_DIRS=(/var/www/html/)
DEST_DIRS+=(/var/proj1/)
DEST_APP=(abc)
DEST_APP+=(abc)

SOURCE_DIR="${STAGING_PATH}${STAGING_DIR}"
SOURCE_FILES=`find $SOURCE_DIR -type f -printf '%f '`

#TIMESTAMP=`date +_%Y-%m%d-%H%Mh%S`
#COPY_CMD_FILE="${STAGING_DIR}_COPY_${TIMESTAMP}.sh"
COPY_CMD_FILE="${STAGING_DIR}_COPY.sh"
echo "#!/usr/bin/env bash" | tee $COPY_CMD_FILE
#PROD_LIST_FILE="${STAGING_DIR}_list_PROD_${TIMESTAMP}.txt"
PROD_LIST_FILE="${STAGING_DIR}_list_PROD.txt"
echo "" | tee $PROD_LIST_FILE

if [ ${DEST_DIRS[0]} ] && [ ${DEST_APP[0]} ] && [ -d ${DEST_DIRS[0]}${DEST_APP[0]} ] 
then
	USE_DEST_0=true
fi
if [ ${DEST_DIRS[1]} ] && [ ${DEST_APP[1]} ] && [ -d ${DEST_DIRS[1]}${DEST_APP[1]} ]
then
	USE_DEST_1=true
fi

for i in $SOURCE_FILES; do 
  if [ $USE_DEST_0 ]
	then
		copy_file_to_dest=`find ${DEST_DIRS[0]}${DEST_APP[0]} -name $i -print`
		if [ $copy_file_to_dest ] 
		then
			source_file=`find $SOURCE_DIR -name $i -print`
			echo echo cp $source_file $copy_file_to_dest | tee -a $COPY_CMD_FILE
			echo cp $source_file $copy_file_to_dest | tee -a $COPY_CMD_FILE
      echo $copy_file_to_dest | tee -a $PROD_LIST_FILE
		fi
	fi
  if [ $USE_DEST_1 ] 
  then
    copy_file_to_dest=`find ${DEST_DIRS[1]}${DEST_APP[1]} -name $i -print`
    if [ $copy_file_to_dest ] 
		then
			echo echo cp $source_file $copy_file_to_dest | tee -a $COPY_CMD_FILE
      echo cp $source_file $copy_file_to_dest | tee -a $COPY_CMD_FILE
      echo $copy_file_to_dest | tee -a $PROD_LIST_FILE
    fi
  fi
done

