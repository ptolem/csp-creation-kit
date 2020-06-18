#!/bin/bash
# Note: One-off execution only! Do not run more than once even in case of failures

# main deps
sudo apt-get update -y
sudo apt-get -y install build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 -y

# cabal
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

# GHC
wget https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-x86_64-deb9-linux.tar.xz
tar -xf ghc-8.6.5-x86_64-deb9-linux.tar.xz
rm ghc-8.6.5-x86_64-deb9-linux.tar.xz
cd ghc-8.6.5
./configure
sudo make install

# Clone cardano-node repo, Build and Publish tools
cd $HOME
mkdir -p ws
cd ws
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --tags
git checkout tags/1.13.0
~/.local/bin/cabal install cardano-node cardano-cli --installdir="$HOME/.local/bin/" # Takes 15+ mins first time around

# Pool setup
cd $HOME
mkdir pool
cd pool
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-topology.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/ff-config.json
mkdir core
mkdir relay
cp ff* core/
cp ff* relay/
rm ff*

# PATH update
echo 'export PATH="~/.cabal/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="~/.local/bin:$PATH"' >> ~/.bashrc