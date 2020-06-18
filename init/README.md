# SAFESTAK [SAFE] Cardano Stake Pool Initialisation Scripts

In an effort to save time setting up the VMs to run the Cardano stake pool I have created the scripts in this folder but please use it with caution as they are incomplete, untested and possibility out-of-date! 

## Prerequisites
It is assumed that the Terraform provisioning stage has completed successfully and all the resulting Azure Cloud infrastructure exists in a pristine state. 

## Notes

### SSH 
Using the SSH key output from Terraform, create the .pem file and ensure the relevant security rules are applied.
 
#### Linux 
`chmod 400 YOUR_PEM_FILE.pem`

#### Windows
```
$path = "YOUR_PEM_FILE.pem"
icacls.exe $path /reset
icacls.exe $path /GRANT:R "$($env:USERNAME):(R)"
icacls.exe $path /inheritance:r
```

### SSH to Provisioned Azure Cloud VMs
`ssh -i YOUR_PEM_FILE.pem YOUR_USERNAME@YOUR_PUBLIC_IP`

Note: If you are using Windows, ensure you have [OpenSSH](https://www.howtogeek.com/336775/how-to-enable-and-use-windows-10s-built-in-ssh-commands/) 

TODO: Using Visual Studio Code Remote - SSH extension.

### Running nodes
Note the public IP of the core and relay VMs from the provisioning. Ensure the topology.json of the core node only has the relay node IP address and the relay node has both the core and the Cardano relay node.
 
#### Relay
```
cardano-node run --topology $HOME/pool/relay/ff-topology.json \
                 --database-path $HOME/pool/relay/db/ \
                 --socket-path $HOME/pool/relay/db/node.socket \
                 --host-addr 127.0.0.1 \
                 --port 3003 \
                 --config $HOME/pool/relay/ff-config.json
```
#### Core
```
cardano-node run --topology $HOME/pool/core/ff-topology.json \
                 --database-path $HOME/pool/core/db/ \
                 --socket-path $HOME/pool/core/db/node.socket \
                 --host-addr 127.0.0.1 \
                 --port 3000 \
                 --config $HOME/pool/core/ff-config.json
```
