# SafeStak [SAFE] Cardano Stake Pool Creation Kit

## Goals
 - Define a declarative representation of cloud infrastructure to host a Cardano stake pool. 
 - Write a set of core scripts to setup and initialise the cardano node software on the cloud VMs 
 - Document the process of provisioning the infrastructure and get the pool up and running.

## Prerequisites (Windows 10)
 - **Azure CLI** [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest#install-or-update)
 - **Terraform** [here](https://www.terraform.io/downloads.html)
 - **Powershell 7** [here](https://aka.ms/PowerShell-Release?tag=v7.0.2)
 - **Visual Studio Code** [here](https://code.visualstudio.com/download) and the **Remote - SSH** extension

## Prerequisites (Ubuntu/Debian)
 - **Azure CLI** `curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`
 - **Terraform**
   - `sudo apt-get install unzip`
   - `wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip` (NOTE: This documented version might be out-of-date, get link to zip file [here](https://www.terraform.io/downloads.html))
   - `unzip terraform_0.12.26_linux_amd64.zip`
   - `sudo mv terraform /usr/local/bin/`
   - `terraform --version` to verify it is the right version
- **Powershell 7** [here](https://aka.ms/PowerShell-Release?tag=v7.0.2)
- **Visual Studio Code** [here](https://code.visualstudio.com/download) and the **Remote - SSH** extension

## Provisioning Azure Infrastructure
Assuming you are currently in the `prov` folder:
 - Login with `az login`
 - Set relevant subscription `az account set --subscription SubscriptionName` (verify using `az account show`)
 - Create `spool-vars.tfvars` variable assignment file with your variables (see spool-vars.tf for reference)
 - Run `terraform init`
 - Run `terraform plan -var-file spool-vars.tfvars`
 - If the output looks good, run `terraform apply -var-file spool-vars.tfvars -auto-approve`
 - This will take about 10 minutes to provision the whole infrastructure. Please refer to the [initialisation scripts](./init/README.md) on how to set up the nodes. 

