# Single-Node ELK on Docker Compose

A minimal ELK Stack (Elasticsearch, Logstash, Kibana) and Filebeat setup using Docker Compose. All services are version 8.15.0.

## Project Directory
```bash
.
├── docker-compose.yml
├── filebeat/
│   └── filebeat.yml
└── logstash/
    └── pipeline/
        └── logstash.conf
```
also notice the project structure, any changes in default structure will be require changes in compose file and maybe the other files.


## Logs
notice where do you put the logs, the default defined path for the logs is `/var/logs/elk/`. as said before any changes in default path will be require changes in compose file and maybe the other files.
```bash
.
├── 20231101.json
├── 20231102.json
├── 20231103.json
├── 20231104.json
```

## Endpoints

Kibana: `http://localhost:5601`

Elasticsearch: `http://localhost:9200`

Logstash (Beats Input): `localhost:5044`
