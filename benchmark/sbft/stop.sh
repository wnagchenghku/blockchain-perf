#!/bin/bash
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

sudo killall -KILL server
