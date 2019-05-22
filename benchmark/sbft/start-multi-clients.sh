#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "start-multi-clients.sh"
let i=0
for client in `cat $CLIENTS`; do
  let client_id=$1+$i
  ssh -oStrictHostKeyChecking=no hkucs@$client $SBFT_HOME/start-clients.sh $1 $2 $client_id $3 $4
  let i=$i+1
done


let M=$2*10+240
echo "run for $M"
sleep $M
for client in `cat $CLIENTS`; do
  ssh -oStrictHostKeyChecking=no hkucs@$client 'killall -KILL client' 
  let i=$i+1
done
