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
├── elasticdump/
│   └── Dockerfile
│   └── export-and-uplod.sh
├── dumps/
├── minio_data/

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
## Components & Pipeline

### Components

**Filebeat:** A lightweight data shipper that tails log files and sends the data to the next stage.

**Logstash:** The pipeline's central data processing engine that transforms and enriches the data.

**Elasticsearch:** The distributed search engine and database where the final, processed data is stored.

**Kibana:** The visualization layer that allows you to explore and analyze the data stored in Elasticsearch.


### Pipeline Design

The pipeline follows a clear, four-step data flow from a log file to a visual dashboard:

**1.Collection**

The Filebeat service continuously monitors a specific directory on the host machine (`/var/log/elk/`) for new log entries in `.json` files. When a new log is added, Filebeat reads it and securely sends it to Logstash.

**2.Processing**

The Logstash service receives the raw log data from Filebeat. It uses a JSON filter to parse the plain text log message into a structured format with distinct fields (e.g., `level`, `message`). This transformation makes the data much easier to search and analyze.

**3.Storage & Indexing**

Logstash forwards the structured data to Elasticsearch. Elasticsearch acts as a powerful database, storing the logs and building a searchable index from them. This allows for incredibly fast and complex queries on a massive amount of log data.

**4.Visualization**

Kibana provides a user-friendly web interface that connects to Elasticsearch. With Kibana, you can search through all the collected logs, create visualizations like charts and graphs, and assemble them into real-time dashboards for monitoring and analysis.

### Data-Flow & User-interaction Diagram


**Data Ingestion Flow:**

This shows how logs travel from the source file to storage:
```bash
                  ┌─────────────────────────┐
                  │ Host Machine            │
                  │ /var/log/elk/*.json     │
                  └───────────┬─────────────┘
                              │ (Reads File via Volume Mount)
                              ▼
                  ┌─────────────────────────┐
                  │ Filebeat Container      │
                  │ (Collects & Forwards)   │
                  └───────────┬─────────────┘
                              │ (Sends Data via Port 5044)
                              ▼
                  ┌─────────────────────────┐
                  │ Logstash Container      │
                  │ (Parses & Transforms)   │
                  └───────────┬─────────────┘
                              │ (Sends Structured Data)
                              ▼
                  ┌─────────────────────────┐
                  │ Elasticsearch Container │
                  │ (Stores & Indexes Data) │
                  └─────────────────────────┘
```


**User Interaction Flow**

This shows how you access and visualize the data:
```bash
                  ┌─────────────────────────┐
                  │ User Web Browser        │
                  └───────────┬─────────────┘
                              │ (Accesses via Port 5601)
                              ▼
                  ┌─────────────────────────┐      ┌─────────────────────────┐
                  │ Kibana Container        ├─────►│ Elasticsearch Container │
                  │ (Web Interface)         │      │ (Serves Data)           │
                  └─────────────────────────┘      └─────────────────────────┘
```

### Endpoints

**Kibana:** `http://localhost:5601`

**Elasticsearch:** `http://localhost:9200`

**Logstash (Beats Input):** `localhost:5044`

### dumping indices intro compressed files:

To prevent index bloat and retain snapshots of Elasticsearch indices, this setup includes a custom `elasticdump` container that continuously monitors for specific index patterns, exports them as `.json.gz` files, and uploads them to MinIO.

Included Patterns
You can adjust these inside the export-and-upload.sh script:
```bash
PATTERNS=("event-logs-" "gc-logs-" "metric-logs-")
```

All compressed dumps are saved in: `./dumps/`
Example structure:
```bash
./dumps/
├── event-logs-2025.07.20.json.gz
├── gc-logs-2025.07.20.json.gz
└── metric-logs-2025.07.20.json.gz
```
MinIO Bucket
The exported .gz files are uploaded to MinIO under a bucket named: `elk-exports`



## Run

Simply:
```bash
docker compose up -d
```




