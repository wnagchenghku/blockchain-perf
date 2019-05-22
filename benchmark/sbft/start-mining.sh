#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

mkdir -p $LOG_DIR

SERVER="$SBFT_SOURCE/build/bftengine/tests/simpleTest/server"
if ! [ -e $SERVER ]; then
	echo "SBFT server executable not found: $SERVER"
	exit 1
fi

cd $SBFT_SOURCE
HOST=`hostname`
nohup $SERVER -id $1 -r $2 -c $3 -cf "$SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt" > $LOG_DIR/sbft_log_$HOST"_"$1 2>&1 &
