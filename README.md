
# Purpose and Scope
This document provides an overview of the elkDeployment repository, an automated ELK stack deployment system that combines infrastructure provisioning, log management, and data archiving capabilities. The system uses Ansible for server preparation and Docker Compose for orchestrating a complete ELK (Elasticsearch, Logstash, Kibana) pipeline with automated data archiving to MinIO storage.


# Infrastructure, Setup & Rotation

---

## Infrastructure Provisioning

Automates server configuration and provisioning using Ansible.

| Component           | Purpose                      | Key Files                |
|---------------------|------------------------------|--------------------------|
| Ansible Inventory   | Target server configuration  | `ansible/inventory.ini`  |
| Ansible Playbook    | Server setup automation      | `ansible/playbook.yaml`  |

---

## ELK Stack Services

Centralized logging using the ELK stack (Elasticsearch, Logstash, Kibana, Filebeat).

| Service       | Port  | Purpose                              | Configuration                     |
|---------------|-------|--------------------------------------|-----------------------------------|
| elasticsearch | 9200  | Search engine and data storage       | Defined in `docker-compose.yml`   |
| logstash      | 5044  | Data processing pipeline             | `logstash/pipeline/logstash.conf` |
| kibana        | 5601  | Web-based visualization interface    | Defined in `docker-compose.yml`   |
| filebeat      | -     | Log file collection agent            | `filebeat/filebeat.yml`           |

---

## Data Archiving System

Handles automated data backup and storage using Elasticdump and MinIO.

| Component            | Purpose                          | Configuration                                                |
|----------------------|----------------------------------|--------------------------------------------------------------|
| elasticdump service  | Automated index export           | `elasticdump/Dockerfile`, `elasticdump/export-and-upload.sh` |
| MinIO storage        | Object storage for compressed archives | Configured in `docker-compose.yml`                     |
| Local dumps directory| `./dumps/` backup location        | Mounted volume                                              |


