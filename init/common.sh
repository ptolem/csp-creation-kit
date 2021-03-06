#!/bin/bash
# Note: One-off execution only! Do not run more than once even in case of failures

echo '========================================================='
echo 'Main Dependencies'
echo '========================================================='
sudo apt-get update -y
sudo apt-get -y install build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 libsodium-dev chrony -y

echo '========================================================='
echo 'Applying Updates / Patches'
echo '========================================================='
sudo unattended-upgrade

echo '========================================================='
echo 'Optimising sysctl.conf and chrony'
echo '========================================================='
sudo cp ~/git/csp-creation-kit/init/sysctl.conf /etc/sysctl.conf
sudo cp ~/git/csp-creation-kit/init/chrony.conf /etc/chrony/chrony.conf
sudo sysctl --system
sudo systemctl restart chrony

echo '========================================================='
echo 'Installing Cabal'
echo '========================================================='
cd $HOME
mkdir -p init
cd init
wget https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
rm cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz cabal.sig
mkdir -p ~/.local/bin
mv cabal ~/.local/bin/
~/.local/bin/cabal update
~/.local/bin/cabal user-config update
sed -i 's/overwrite-policy:/overwrite-policy: always/g' ~/.cabal/config

echo '========================================================='
echo 'Installing GHC'
echo '========================================================='
wget https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-x86_64-deb9-linux.tar.xz
tar -xf ghc-8.6.5-x86_64-deb9-linux.tar.xz
rm ghc-8.6.5-x86_64-deb9-linux.tar.xz
cd ghc-8.6.5
./configure
sudo make install

echo '========================================================='
echo 'Building and Publishing Cardano Binaries'
echo '========================================================='
cd $HOME
mkdir -p git
cd git
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --tags
git checkout release/1.14.x
echo -e "package cardano-crypto-praos\n  flags: -external-libsodium-vrf" > cabal.project.local
~/.local/bin/cabal install cardano-node cardano-cli --installdir="$HOME/.local/bin/" # Takes 15+ mins first time around

echo '========================================================='
echo 'Generating node artefacts - genesis, config and topology'
echo '========================================================='
cd $HOME
mkdir -p node/config
mkdir -p node/socket
cd node/config
wget -O topology.json https://hydra.iohk.io/build/3245987/download/1/shelley_testnet-topology.json
wget -O genesis.json https://hydra.iohk.io/build/3245987/download/1/shelley_testnet-genesis.json
wget -O config.json https://hydra.iohk.io/build/3245987/download/1/shelley_testnet-config.json
sed -i 's/"TraceBlockFetchDecisions": false/"TraceBlockFetchDecisions": true/g' config.json
sed -i 's/"ViewMode": "SimpleView"/"ViewMode": "LiveView"/g' config.json
sed -i 's/shelley_testnet-genesis/genesis/g' config.json

echo '========================================================='
echo 'Updating PATH to binaries and setting socket env variable'
echo '========================================================='
echo 'export PATH="~/.cabal/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="~/.local/bin:$PATH"' >> ~/.bashrc
echo 'export CARDANO_NODE_SOCKET_PATH=/home/ss/node/socket/node.socket' >> ~/.bashrc