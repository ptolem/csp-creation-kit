variable "pool-location" {
  type        = string
  description = "Stake Pool location from verified location list (az account list-locations -o table)"
}
variable "resource-prefix" {
  type        = string
  description = "Prefix to apply to all Stake Pool resources"
}
variable "storage-prefix" {
  type        = string
  description = "Prefix abbreviation to apply to storage account"
}
variable "vm-username" {
  type        = string
  description = "VM username for all nodes"
}
variable "corevm-size" {
  type        = string
  description = "Stake Pool core node VM size (az vm list-sizes --location northeurope -o table)"
}
variable "corevm-comp-name" {
  type        = string
  description = "Stake Pool core node VM computer name"
}
variable "relayvm-size" {
  type        = string
  description = "Stake Pool relay node VM size (az vm list-sizes --location northeurope -o table)"
}
variable "relayvm-comp-name" {
  type        = string
  description = "Stake Pool relay node VM computer name"
}
variable "relayvm-node-port" {
  type        = string
  description = "Port to run the relay node on"
}
variable "tag-platform" {
  type        = string
  description = "Platform tag assigned to all resources"
}
variable "tag-stage" {
  type        = string
  description = "Stage tag assigned to all resources"
}
variable "tag-data-classification" {
  type        = string
  description = "Data classification tag assigned to all resources"
}