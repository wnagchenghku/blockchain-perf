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
finished=false
while :; do
  if [[ $i -eq 0 ]]; then
    echo "replicas_config:" >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
  fi

  for host in `cat $HOSTS`; do
    let port=3410+$i
    echo " - $host:$port " >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
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

i=0
finished=false
while :; do
  if [[ $i -eq 0 ]]; then
    echo "clients_config:" >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
  fi

  for client in `cat $CLIENTS`; do
    let port=4444+$i
    echo " - $client:$port " >> $SBFT_SOURCE/build/bftengine/tests/simpleTest/scripts/sample_config.txt
    let i=$i+1
    if [[ "$i" -lt "$3" ]]; then
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
