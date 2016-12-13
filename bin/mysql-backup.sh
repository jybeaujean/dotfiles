#!/bin/bash
#--------------------------------------------------------------------
# DATE 		: 23 septembre 2005. 
# AUTHOR 	: Jean-Yves Beaujean
# DESCRIPTION 	: This script dumps every mysql database present on the server
#                 File format = databasename-day.sql 
# USAGE	: shell$ mysql_backup.sh user password host
# PARAMETER : login, password et host
# CHANGELOG  : 22-05-2007	- remove log file 
#				- code cleaning

# ---------------------------- VAR ---------------------------
USER="root";
PASSWORD="";
MYSQL_HOST="localhost";

DEST="~/mysql-`date +%Y-%m-%d`" # DO NOT END WITH A   /

DAY=`date +%d`	
# ---------------------------- END VAR ---------------------------



# ----------------------------  FUNCTIONS -----------------------------
function usage
{
	echo "USAGE : shell$ mysql_backup [user] [password] [host] [dest_directory]";
	exit 1;
}




# Check parameters
#-----------------------------------------------------------------------------
# If one missing, exit 
# -z --> string is null ?
# -n --> string is not null ?

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] ; then
	echo "ERROR : Missing parameters";
	usage
fi

USER=$1
PASSWORD=$2
MYSQL_HOST=$3
DEST=$4

# Check if DEST exists and create it
mkdir -p $DEST



echo "`date`: ----------- MYSQL BACKUP ----------- /START"
# Dump command
MYSQLDUMP_CMD="mysqldump --opt --routines --user=$USER --password=$PASSWORD --host=$MYSQL_HOST"
MYSQL_CMD="mysql --skip-column-names --user=$USER --password=$PASSWORD --host=$MYSQL_HOST"
#-----------------------------------------------------------------------------


# Step 1 :  get databases list
OUTPUT="db";
$MYSQL_CMD --execute="show databases" > $OUTPUT
RETVAL=$?
if [ ! $RETVAL -eq 0 ]; then
	echo "`date`: ERROR : Unable to list databases"
	rm $OUTPUT
	exit $RETVAL
fi

# Step 2 : Dump each DB
while read db
do
   echo "`date` : Backuping database [$db]..."
 	$MYSQLDUMP_CMD $db | gzip > $DEST/$db-$DAY.sql.gz
done < $OUTPUT

# Cleaning
echo "`date` : Clean temporary files"
rm $OUTPUT

echo "`date`: ----------- MYSQL BACKUP ----------- /END"

