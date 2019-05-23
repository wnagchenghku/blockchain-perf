#!/bin/bash
#nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

i=0

while :; do
  for host in `cat $HOSTS`; do
    ssh -oStrictHostKeyChecking=no hkucs@$host $SBFT_HOME/start-mining.sh $i $1 $2
    let i=$i+1
  done

  if [[ "$i" -lt $1 ]]; then
  	continue
  fi

  break
done
