#!/bin/sh
# This script change files extensions 
# usage : rename.sh /home/user htm html

DIR=$1
EXT_SOURCE=$2
EXT_TARGET=$3

for FILE in `find $DIR -name *.$EXT_SOURCE` ; do
	dirname=`dirname $FILE`
	basename=`basename $FILE`
	echo "mv $FILE $dirname/$basename.$EXT_TARGET"
	mv $FILE $dirname/$basename.$EXT_TARGET
done
