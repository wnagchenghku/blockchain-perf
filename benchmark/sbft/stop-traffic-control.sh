#!/bin/bash
#arg nnodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

i=0
for host in `cat $HOSTS`; do
  ssh -oStrictHostKeyChecking=no hkucs@202.45.128.171 'device=$(ip -oneline -4 addr show scope global | grep "10.22" | tr -s " " | tr "/" " " | cut -f 2 -d " "); sudo tc qdisc del dev $device root; sudo tc qdisc del dev lo root'
done
