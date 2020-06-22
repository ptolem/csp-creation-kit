#!/bin/bash
# Note: One-off execution only! Do not run more than once even in case of failures

# create vital keys and addresses
echo '========================================================='
echo 'Creating Keys and Addresses'
echo '========================================================='
cd $HOME
mkdir -p wallets/spool
cd ~/wallets/spool
cardano-cli shelley address key-gen \
 --verification-key-file payment.vkey \
 --signing-key-file payment.skey
cardano-cli shelley stake-address key-gen \
 --verification-key-file stake.vkey \
 --signing-key-file stake.skey
cardano-cli shelley address build \
 --payment-verification-key-file payment.vkey \
 --stake-verification-key-file stake.vkey \
 --out-file payment.addr \
 --testnet-magic 42
cardano-cli shelley stake-address build \
 --stake-verification-key-file stake.vkey \
 --out-file stake.addr \
 --testnet-magic 42

# query generated address
echo '========================================================='
echo 'Showing details of payment.addr'
echo '========================================================='​
export CARDANO_NODE_SOCKET_PATH=~/cardano-node/socket/node.socket
cardano-cli shelley query utxo \
 --address $(cat payment.addr) \
 --testnet-magic 42

# faucet (only for shelley testnet)
echo '========================================================='
echo 'Getting the loot from the faucet'
echo '========================================================='
curl -v -XPOST "https://faucet.ff.dev.cardano.org/send-money/$(cat payment.addr)"

# secondary payment address
echo '========================================================='
echo 'Creating Secondary Key and Addresses'
echo '========================================================='
cardano-cli shelley address key-gen \
 --verification-key-file payment2.vkey \
 --signing-key-file payment2.skey
cardano-cli shelley address build \
 --payment-verification-key-file payment2.vkey \
 --stake-verification-key-file stake.vkey \
 --out-file payment2.addr \
 --testnet-magic 42

echo '========================================================='
echo 'Getting Protocol Parameters'
echo '========================================================='
cardano-cli shelley query protocol-parameters \
   --testnet-magic 42 \
   --out-file protocol.json

echo '========================================================='
echo 'Querying the tip of the blockchain'
echo '========================================================='
cardano-cli shelley query tip --testnet-magic 42

# query generated address
echo '========================================================='
echo 'Showing details of payment.addr'
echo '========================================================='
cardano-cli shelley query utxo \
 --address $(cat payment.addr) \
 --testnet-magic 42
 