#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

LOG_DIR=$LOG_DIR/$1
mkdir -p $LOG_DIR

cd $SBFT_HOME
nohup $EXE_HOME/server -id $1 -r $2 -c $3 -cf "$EXE_HOME/scripts/sample_config.txt" > $LOG_DIR/client_$host"_"$1 2>&1 &
