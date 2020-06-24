# SafeStak [SAFE] Cardano Stake Pool Initialisation Kit

In an effort to save time setting up the VMs to run the Cardano stake pool I have created the scripts in this folder but please use it with caution as they are incomplete, untested and possibility out-of-date! 

## Prerequisites
It is assumed that the Terraform provisioning stage has completed successfully and all the resulting Azure Cloud infrastructure exists in a pristine state. 

## SSH 
Using the SSH key output from Terraform, create the .pem file and ensure the relevant security rules are applied with the key prep scripts below.
 
### Linux SSH key prep  
`chmod 400 YOUR_PEM_FILE.pem`

### Windows SSH key prep 
```
$path = "YOUR_PEM_FILE.pem"
icacls.exe $path /reset
icacls.exe $path /GRANT:R "$($env:USERNAME):(R)"
icacls.exe $path /inheritance:r
```
### SSH to Provisioned Azure Cloud VMs
`ssh -i YOUR_PEM_FILE.pem YOUR_USERNAME@YOUR_PUBLIC_IP`

Note: If you are using Windows, ensure you have [OpenSSH](https://www.howtogeek.com/336775/how-to-enable-and-use-windows-10s-built-in-ssh-commands/) 

TODO: Instructions on how to use Visual Studio Code Remote - SSH extension.

### Troubleshooting SSH issues
If you are unable to SSH to the newly created VMs please check the SSH NSG rule in the Azure Portal and ensure your current IP is correct.

## Running init scripts
```
cd $HOME
mkdir -p git
cd git
git clone https://github.com/ptolem/csp-creation-kit
cd csp-creation-kit/init
bash common.sh
```

### Relay nodes
`bash relay.sh` and edit the ff-topology.json file to ensure it follows the template in [ff-topology-relay.jsont](./ff-topology-relay.jsont). 

### Core nodes
`bash core.sh` and edit the ff-topology.json file to ensure it follows the template in [ff-topology-relay.jsont](./ff-topology-core.jsont). 