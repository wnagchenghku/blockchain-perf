#!/bin/bash
#num_clients num_nodes threads tx_rate [-drop]
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "start-multi-clients.sh"
let i=0
for client in `cat $CLIENTS`; do
    echo $client index $i
    ssh -oStrictHostKeyChecking=no hkucs@$client $SBFT_HOME/start-clients.sh $1 $2 $i $3 $4
  let i=$i+1
done


let M=$2*10+240
echo "run for $M"
sleep $M
for client in `cat $CLIENTS`; do
  echo $client index $i
  ssh -oStrictHostKeyChecking=no hkucs@$client 'killall -KILL client' 
  let i=$i+1
done
