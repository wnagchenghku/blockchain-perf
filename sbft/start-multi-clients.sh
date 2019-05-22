#!/bin/bash
#num_clients num_nodes threads tx_rate [-drop]
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "start-multi-clients.sh"
let i=0
let IDX=$1/2
for client in `cat $CLIENTS`; do
  if [[ $i -lt $IDX ]]; then
    echo $client index $i
    ssh -oStrictHostKeyChecking=no hkucs@$client $SBFT_HOME/start-clients.sh $3 $i $2 $4
    #echo "rp 10"
    #sleep 10
  fi
  let i=$i+1
done


let M=$2*10+240
echo "run for $M"
sleep $M
for client in `cat $CLIENTS`; do
  echo $client index $i
  ssh -oStrictHostKeyChecking=no $client 'killall -KILL driver' 
  let i=$i+1
done
