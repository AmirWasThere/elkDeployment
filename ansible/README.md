# Ansible Kubernetes Single-Node Setup

This repository contains Ansible playbooks and inventories to automate the setup of a single-node Kubernetes cluster along with essential tools for warming up to install ELK,beats,etc.

## Files

- `inventory.ini`: inventory file with root credentials for initial setup
- `playbook.yaml`: initial setup (installing git,docker,etc)

## Usage

as you know, just simply Run the playbook with:

```bash
ansible-playbook -i inventory.ini playbook.yaml
