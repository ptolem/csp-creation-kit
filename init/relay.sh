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
