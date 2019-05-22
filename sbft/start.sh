#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

nohup server -debug --id -cf -r -c > $ETH_DATA/../eth_log 2>&1 &

sleep 1

