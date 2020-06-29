#!/bin/bash
# Note: One-off execution only! Do not run more than once even in case of failures
# Don't forget to run `source ~/.bashrc` and `export CARDANO_NODE_SOCKET_PATH=~/node/socket/node.socket`

echo '========================================================='
echo 'Re-Generating Stake Pool Operational Certificate'
echo '========================================================='
CTIP=$(cardano-cli shelley query tip --testnet-magic 42 | egrep -o '[0-9]+' | head -n 1)
SLOTSPERKESPERIOD=$(cat ~/node/config/genesis.json | grep slotsPerKESPeriod | egrep -o '[0-9]+')
KESP=$(expr $CTIP / $SLOTSPERKESPERIOD)
cardano-cli shelley node issue-op-cert \
--kes-verification-key-file ~/kc/kes.vkey \
--cold-signing-key-file ~/kc/cold.skey \
--operational-certificate-issue-counter ~/kc/cold.counter \ # This gets incremented
--kes-period $KESP --out-file ~/kc/node.cert