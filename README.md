# Bitcoin Node Ansible

Set of ansible roles to install a Bitcoin node (& Lighntning Network Node) on a Debian machine (tested on Raspbian Raspberry Pi 4).


# Supported services

- Tor (installed from source using external role)
- bitcoind
- lnd
- btc-rpc-explorer
+ some additional helper scripts


## Setting up a external disk

```
sudo fdisk -l
sudo fdisk /dev/sdb
mkfs.ext4 /dev/sdb1
sudo mkfs.ext4 /dev/sdb1
sudo e2label /dev/sdb1 bitcoin
```