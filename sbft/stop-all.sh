#!/bin/bash
#arg nnodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

i=0
for host in `cat $CLIENTS`; do
    ssh -oStrictHostKeyChecking=no hkucs@$host sudo killall -KILL client 
    echo done node $host
done

for host in `cat $HOSTS`; do
  if [[ $i -lt $1 ]]; then
    ssh -oStrictHostKeyChecking=no hkucs@$host $SBFT_HOME/stop.sh
    echo done node $host
  fi
  let i=$i+1
done


