#!/usr/bin/env bash


logDir="$(PWD)/logs"
pkiDir="$(PWD)/pki/database.db"

if [ -f $pkiDir ]
then
    rm -f $pkiDir
    echo "Removed existing PKI files"
else
    echo "Nothing to remove. The PKI directory does not exists"
fi


if [ -d $logDir ]
then
    echo "Removing existing logs and creating a new log folder"
    rm -rf $logDir
    mkdir $logDir
else
    echo "Nothing to remove. The logs directory does not exist."
fi

function kill_port() {
    PID=$(lsof -t -i:$1)
    echo "$PID"
    kill -TERM ${PID} || kill -KILL ${PID}
}

for var in "$@"
do
    echo ${var}
    kill_port ${var}
done
