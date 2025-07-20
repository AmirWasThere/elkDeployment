# Ansible Single-Node Initial Setup

This repository contains Ansible playbooks and inventories to automate the setup of a single-node Kubernetes cluster along with essential tools for warming up to install ELK,beats,etc.

## Files

- `inventory.ini`: inventory file with root credentials for initial setup
- `playbook.yaml`: initial setup (installing git,docker,etc)

## Usage
try ro run ssh-copy-id first, it will add your key to server 
```bash
ssh-copy-id root@a.b.c.d -i ./.ssh/id_rsa
```
You have freed yourself actually.



as you know, just simply Run the playbook with:

```bash
ansible-playbook -i inventory.ini playbook.yaml
```
