#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "start-multi-clients.sh"

let i=0
while :; do
  for client in `cat $CLIENTS`; do
    let client_id=$1+$i
    ssh -oStrictHostKeyChecking=no hkucs@$client $SBFT_HOME/start-clients.sh $1 $2 $client_id $3 $4
    let i=$i+1
  done

  if [[ "$i" -lt "$2" ]]; then
  	continue
  fi

  break
done

let M=$1*10+240
echo "run for $M"
sleep $M
for client in `cat $CLIENTS`; do
  ssh -oStrictHostKeyChecking=no hkucs@$client 'killall -KILL client'
done
