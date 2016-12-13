#!/bin/sh

# This script reads a file where you've list some other files ( css, jss ) and adds them in a single file
function usage
{
	echo "Usage : shell> inliner.sh [input] [output]";
	echo "Example : inliner.sh css.list assets.css"
	exit 1;
}


if [ -z "$1" ] || [ -z "$2" ]  ; then
	echo "ERREUR : Missing parameters ! ";
	usage
fi


INPUT=$1
OUTPUT=$2


while read entry
do
   echo "add : [$entry]..."     
   cat $entry >> $OUTPUT

done < $INPUT
