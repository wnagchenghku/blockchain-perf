#!/bin/bash
#arg num_nodes #num_threads num_clients tx_rate [-drop]
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "run-bench.sh"
./stop-all.sh $1 

./init-all.sh $1 
./start-all.sh $1 

let M=2*$1
echo "sleep $M"
sleep $M

./start-multi-clients.sh $3 $1 $2 $4 $5 

./stop-all.sh $1

sleep 5

