#!/bin/bash
# num_nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "Generating new keys..."

rm -f private_replica_*

cd $SBFT_HOME
$SBFT_HOME/build/tools/GenerateConcordKeys -n $1 -f $2 -o private_replica_


echo "Generating sample_config.txt..."
rm -f $EXE_HOME/scripts/sample_config.txt
i=0
for host in `cat $HOSTS`; do
  if [[ $i -eq 0 ]]; then
  	echo "replicas_config:"
  echo " - $host:3410 " >> $EXE_HOME/scripts/sample_config.txt
  fi
  let i=$i+1
  echo $i
done

i=0
for client in `cat $CLIENTS`; do
  if [[ $i -eq 0 ]]; then
  	echo "clients_config:"
  echo " - $host:4444 " >> $EXE_HOME/scripts/sample_config.txt
  fi
  let i=$i+1
  echo $i
done