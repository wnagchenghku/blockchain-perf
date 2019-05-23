#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

if [ $# -lt 4 ]; then
	echo "Usage: $0 <num_of_replicas> <num_of_clients> <num_of_faulty> <num_of_slow>"
	exit 1
fi

NUM_OF_REPLICAS=$1
NUM_OF_CLIENTS=$2
NUM_OF_FAULTY=$3
NUM_OF_SLOW=$4


if [[ $(expr 3*$NUM_OF_FAULTY+2*NUM_OF_SLOW+1) -ne "$NUM_OF_REPLICAS" ]]; then
	echo "N = 3f + 2c + 1 is not satisfied"
	exit 1
fi

echo "run-bench.sh"
./stop-all.sh $NUM_OF_REPLICAS 

./init-all.sh $NUM_OF_REPLICAS $NUM_OF_FAULTY $NUM_OF_CLIENTS
./start-all.sh $NUM_OF_REPLICAS $NUM_OF_CLIENTS

let M=2*$NUM_OF_REPLICAS
echo "sleep $M"
sleep $M

./start-multi-clients.sh $NUM_OF_REPLICAS $NUM_OF_CLIENTS $NUM_OF_FAULTY $NUM_OF_SLOW

./stop-all.sh $1

sleep 5

