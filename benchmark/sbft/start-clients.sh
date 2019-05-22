#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh
# args= <num_of_replicas> <num_of_clients> index <num_of_faulty> <num_of_slow> 

LOG_DIR=$LOG_DIR/exp_$1"_"replicas_$2"_"clients

NUM_OF_ITERATIONS=2800
INITIAL_RETRY_TIMEOUT_MILLI=1100
MIN_RETRY_TIMEOUT_MILLI=1000
MAX_RETRY_TIMEOUT_MILLI=2000
SENDS_REQUEST_TO_ALL_REPLICAS_FIRST_THRESH=2
SENDS_REQUEST_TO_ALL_REPLICAS_PERIOD_THRESH=2
PERIODiC_RESET_THRESH=30

CLIENT="$SBFT_SOURCE/build/bftengine/tests/simpleTest/client"
if ! [ -e $CLIENT ]; then
	echo "SBFT client executable not found: $CLIENT"
	exit 1
fi

HOST=`hostname`
cd $SBFT_SOURCE
nohup $CLIENT -i $NUM_OF_ITERATIONS -r $1 -cl $2 -id $3 -f $4 -c $5 -cf "$SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt" -irt INITIAL_RETRY_TIMEOUT_MILLI -minirt MIN_RETRY_TIMEOUT_MILLI -maxrt MAX_RETRY_TIMEOUT_MILLI -srft SENDS_REQUEST_TO_ALL_REPLICAS_FIRST_THRESH -srpt SENDS_REQUEST_TO_ALL_REPLICAS_PERIOD_THRESH -prt PERIODiC_RESET_THRESH > $LOG_DIR/client_$HOST"_"$3 2>&1 &
