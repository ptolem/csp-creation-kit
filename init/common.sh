#!/bin/bash
# Note: One-off execution only! Do not run more than once even in case of failures

# main deps
echo '========================================================='
echo 'Main Dependencies'
echo '========================================================='
sudo apt-get update -y
sudo apt-get -y install build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget libncursesw5 -y

# updates/security patches
echo '========================================================='
echo 'Applying Updates / Patches'
echo '========================================================='
sudo unattended-upgrade

# cabal
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

# ghc
echo '========================================================='
echo 'Installing GHC'
echo '========================================================='
wget https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-x86_64-deb9-linux.tar.xz
tar -xf ghc-8.6.5-x86_64-deb9-linux.tar.xz
rm ghc-8.6.5-x86_64-deb9-linux.tar.xz
cd ghc-8.6.5
./configure
sudo make install

# clone cardano-node repo, build and publish binaries
echo '========================================================='
echo 'Building and Publishing Cardano Binaries'
echo '========================================================='
cd $HOME
mkdir -p ws
cd ws
git clone https://github.com/input-output-hk/cardano-node.git
cd cardano-node
git fetch --all --tags
git checkout tags/1.13.0-rewards
~/.local/bin/cabal install cardano-node cardano-cli --installdir="$HOME/.local/bin/" # Takes 15+ mins first time around

# path update to include binaries
echo '========================================================='
echo 'Updating PATH to binaries'
echo '========================================================='
echo 'export PATH="~/.cabal/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="~/.local/bin:$PATH"' >> ~/.bashrc
