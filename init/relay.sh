#!/bin/bash

# Node setup
cd $HOME
mkdir -p relay-node
cd relay-node
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-topology.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-config.json

echo 'export CARDANO_NODE_SOCKET_PATH=~/cardano-relay-node/db/node.socket​' >> ~/.bashrc
