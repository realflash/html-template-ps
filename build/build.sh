#!/bin/bash
DIR="HTMLTemplate"
NAME="html-template-ps"
VERSION="0.2.3"
OUT="$NAME-v$VERSION.zip"

function make
{
	if [[ ! -d $DIR ]]; then
	{
		mkdir $DIR
	}
	else
	{
		rm -rf $DIR
	}
	fi

	cp -r ../source/* $DIR
	cp -r ../aux/* $DIR

	zip -9 -r $OUT $DIR

}

function clean
{
	rm -rf $DIR
	rm -f $OUT
}

if [[ "$1" == "clean" || "$1" == "CLEAN" ]]; then
{
	clean
}
else
{
	clean
	make
}
fi
