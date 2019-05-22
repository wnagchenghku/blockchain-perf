#!/bin/bash
# num_nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "Generating new keys..."

cd $SBFT_SOURCE

rm -f private_replica_*

$SBFT_SOURCE/build/tools/GenerateConcordKeys -n $1 -f $2 -o private_replica_


echo "Generating sample_config.txt..."
rm -f $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
i=0
for host in `cat $HOSTS`; do
  if [[ $i -eq 0 ]]; then
  	echo "replicas_config:" >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
  fi
  echo " - $host:3410 " >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
  let i=$i+1
  echo $i
done

i=0
for client in `cat $CLIENTS`; do
  if [[ $i -eq 0 ]]; then
  	echo "clients_config:" >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
  fi
  echo " - $host:4444 " >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
  let i=$i+1
  echo $i
done