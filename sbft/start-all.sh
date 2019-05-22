#!/bin/bash
#nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

i=0
for host in `cat $HOSTS`; do
  if [[ $i -lt $1 ]]; then
    ssh -oStrictHostKeyChecking=no hkucs@$host $ETH_HOME/start-mining.sh
    echo done node $host
  fi
  let i=$i+1
done
