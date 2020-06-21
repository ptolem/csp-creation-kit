#!/bin/bash
# Note: One-off execution only! Do not run more than once even in case of failures

# Node setup
cd $HOME
mkdir -p cardano-node/config
mkdir -p cardano-node/socket
cd cardano-node/config
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-topology.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-config.json
sed -i 's/"TraceBlockFetchDecisions": false/"TraceBlockFetchDecisions": true/g' ff-config.json
sed -i 's/"ViewMode": "SimpleView"/"ViewMode": "LiveView"/g' ff-config.json

# Create Keys and Addresses
cd $HOME
mkdir -p wallets/spool
cd ~/wallets/spool
cardano-cli shelley address key-gen --verification-key-file payment.vkey --signing-key-file payment.skey
cardano-cli shelley stake-address key-gen --verification-key-file stake.vkey --signing-key-file stake.skey
cardano-cli shelley address build \
 --payment-verification-key-file payment.vkey \
 --stake-verification-key-file stake.vkey \
 --out-file payment.addr \
 --testnet-magic 42
cardano-cli shelley stake-address build \
 --stake-verification-key-file stake.vkey \
 --out-file stake.addr \
 --testnet-magic 42

echo 'export CARDANO_NODE_SOCKET_PATH=~/cardano-node/socket/node.socket​' >> ~/.bashrc