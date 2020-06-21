# SafeStak [SAFE] Cardano Stake Pool Operation Kit

## Configuration Update
Change ff-config.json - "TraceBlockFetchDecisions": "true" and "ViewMode": "LiveView"

## Running nodes
Note the public IP of the core and relay VMs from the provisioning. Ensure the topology.json of the core node only has the relay node IP address and the relay node has both the core and the Cardano relay node. Please see the ff-topology-core.jsont and ff-topology-relay.jsont files for reference.

## Relay
```
cardano-node run --topology $HOME/cardano-node/ff-topology.json \
                 --database-path $HOME/cardano-node/db/ \
                 --socket-path $HOME/cardano-node/db/node.socket \
                 --host-addr 0.0.0.0 \
                 --port 3002 \
                 --config $HOME/cardano-node/ff-config.json
```
### Core
```
cardano-node run --topology $HOME/core-node/ff-topology.json \
                 --database-path $HOME/core-node/db/ \
                 --socket-path $HOME/core-node/db/node.socket \
                 --host-addr 127.0.0.1 \
                 --port 3000 \
                 --config $HOME/core-node/core/ff-config.json
```

### Troubleshooting
Using commands to check that the ndoes are running and listening https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/
