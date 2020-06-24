# SafeStak [SAFE] Cardano Stake Pool Operation Kit

## Configuration Update
Change ff-config.json - "TraceBlockFetchDecisions": "true" and "ViewMode": "LiveView"

## Running nodes
Note the public IP of the core and relay VMs from the provisioning. Ensure the topology.json of the core node only has the relay node IP address and the relay node has both the core and the Cardano relay node. Please see the ff-topology-core.jsont and ff-topology-relay.jsont files for reference.

## Relay
```
cardano-node run \
  --topology ~/cardano-node/config/ff-topology.json \
  --database-path ~/cardano-node/db/ \
  --socket-path ~/cardano-node/socket/node.socket \
  --host-addr 0.0.0.0 \
  --port 3001 \
  --config ~/cardano-node/config/ff-config.json
```
### Core (standard node)
```
cardano-node run \
  --topology ~/cardano-node/config/ff-topology.json \
  --database-path ~/cardano-node/db/ \
  --socket-path ~/cardano-node/socket/node.socket \
  --host-addr 127.0.0.1 \
  --port 3000 \
  --config ~/cardano-node/config/ff-config.json
```
### Core (block producing node)
```
cardano-node run \
  --topology ~/cardano-node/config/ff-topology.json \
  --database-path ~/cardano-node/db/ \
  --socket-path ~/cardano-node/socket/node.socket \
  --host-addr 127.0.0.1 \
  --port 3000 \
  --config ~/cardano-node/config/ff-config.json \
  --shelley-kes-key ~/kc/kes.skey \
  --shelley-vrf-key ~/kc/vrf.skey \
  --shelley-operational-certificate ~/kc/node.cert
```

## Troubleshooting
Some guidance from [this article](https://www.cyberciti.biz/faq/what-process-has-open-linux-port/).
### Get Process Info
`ps aux | grep cardano`
### Get Network Status
`sudo ss -tulpn | grep 3000` or `netstat -tulpn | grep 3000` or `lsof -i :3000`

### TODO: systemd
