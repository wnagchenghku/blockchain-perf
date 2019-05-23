#!/bin/bash
#nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

i=0
finished=false
while :; do
  for host in `cat $HOSTS`; do
    ssh -oStrictHostKeyChecking=no hkucs@$host $SBFT_HOME/start-mining.sh $i $1 $2
    let i=$i+1
    if [[ "$i" -lt "$1" ]]; then
      continue
    else
      finished=true
      break
    fi
  done

  if [[ "$finished" = true ]]; then
    break
  fi
done
