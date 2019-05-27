#!/bin/bash
#arg nnodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

i=0
for host in `cat $HOSTS`; do
  ssh -oStrictHostKeyChecking=no hkucs@$host sudo tc qdisc add dev lo root handle 1:0 netem delay 100msec
  
  if [[ "$host" == "202.45.128.160" ]] || [[ "$host" = "202.45.128.161" ]]; then
  	ssh -oStrictHostKeyChecking=no hkucs@$host sudo tc qdisc add dev enp5s0 root netem delay 100ms
  elif [[ "$host" == "202.45.128.170" ]]; then
  	ssh -oStrictHostKeyChecking=no hkucs@$host sudo tc qdisc add dev enp179s0 root netem delay 100ms
  elif [[ "$host" == "202.45.128.176" ]] || [[ "$host" == "202.45.128.177" ]] || [[ "$host" == "202.45.128.178" ]] || [[ "$host" == "202.45.128.179" ]] || [[ "$host" == "202.45.128.180" ]]; then
  	ssh -oStrictHostKeyChecking=no hkucs@$host sudo tc qdisc add dev enp1s0f1 root netem delay 100ms
  elif [[ "$host" == "202.45.128.171" ]] || [[ "$host" == "202.45.128.172" ]] || [[ "$host" == "202.45.128.173" ]] || [[ "$host" == "202.45.128.174" ]] || [[ "$host" == "202.45.128.175" ]]; then
  	ssh -oStrictHostKeyChecking=no hkucs@$host sudo tc qdisc add dev enp1s0d1 root netem delay 100ms
  elif [[ "$host" == "202.45.128.162" ]]; then
  	ssh -oStrictHostKeyChecking=no hkucs@$host sudo tc qdisc add dev enp5s0d1 root netem delay 100ms
  fi

done
