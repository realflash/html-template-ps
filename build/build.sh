#!/bin/bash
DIR="HTMLTemplate"
NAME="html-template-ps"
VERSION="0.1"

if [[ ! -d $DIR ]]; then
{
	mkdir $DIR
}
else
{
	rm -rf $DIR
}
fi

cp -r ../source $DIR
cp -r ../aux/* $DIR

zip -9 $NAME-v$VERSION.zip $DIR
