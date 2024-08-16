# Docker Nomie6 OSS
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/rogerrum/docker-nomie6-oss)](https://hub.docker.com/r/rogerrum/docker-nomie6-oss/tags)
[![license](https://img.shields.io/github/license/rogerrum/docker-nomie6-oss)](https://github.com/rogerrum/docker-nomie6-oss/blob/main/LICENSE)
[![DockerHub pulls](https://img.shields.io/docker/pulls/rogerrum/docker-nomie6-oss.svg)](https://hub.docker.com/r/rogerrum/docker-nomie6-oss/)
[![DockerHub stars](https://img.shields.io/docker/stars/rogerrum/docker-nomie6-oss.svg)](https://hub.docker.com/r/rogerrum/docker-nomie6-oss/)
[![GitHub stars](https://img.shields.io/github/stars/rogerrum/docker-nomie6-oss.svg)](https://github.com/rogerrum/docker-nomie6-oss)
[![Contributors](https://img.shields.io/github/contributors/rogerrum/docker-nomie6-oss.svg)](https://github.com/rogerrum/docker-nomie6-oss/graphs/contributors)
[![Docker Image CI](https://github.com/rogerrum/docker-nomie6-oss/actions/workflows/docker-image.yml/badge.svg)](https://github.com/rogerrum/docker-nomie6-oss/actions/workflows/docker-image.yml)


A Docker container for [Nomie6 OSS](https://github.com/open-nomie/nomie6-oss), an open-source personal data tracking tool.

This repository provides a Dockerized version of Nomie6 OSS, making it easy to deploy the application without needing to build it locally.

## Overview

Nomie6 OSS is a personal data tracking tool designed to help you monitor and analyze your daily activities. You can deploy Nomie6 OSS using pre-built Docker images available from:

- **Docker Hub:** `rogerrum/nomie6-oss`
- **GitHub Container Registry:** `ghcr.io/rogerrum/nomie6-oss`

This Docker wrapper simplifies deploying Nomie6 OSS in a containerized environment.

## Prerequisites

- **Docker:** Ensure Docker is installed and running on your machine. Download it from [Docker's official website](https://www.docker.com/get-started).
- **Docker Compose:** Install Docker Compose following the instructions [here](https://docs.docker.com/compose/install/).

## Usage

### Nomie6 OSS
For a basic setup, use the following `docker-compose.yml` configuration:

```yaml
version: '3.8'
services:
  nomie6:
    image: ghcr.io/rogerrum/nomie6-oss
    ports:
      - "3000:80"
```

To start the Nomie6 OSS container, run:
```bash
docker-compose up -d
```

To stop the Nomie6 OSS container, run:
```bash
docker-compose down
```

### Nomie6 OSS with CouchDB
For a setup with CouchDB for data persistence, use the following docker-compose.yml configuration:

```yaml
version: '3.8'
services:
  nomie6:
    image: ghcr.io/rogerrum/nomie6-oss
    ports:
      - "3000:80"
    environment:
      - COUCHDB_URL=http://couchdb:5984
    depends_on:
      - couchdb

  couchdb:
    image: couchdb:3.2
    ports:
      - "5984:5984"
    volumes:
      - couchdb_data:/opt/couchdb/data
      - ./couchdb.ini:/opt/couchdb/etc/local.d/config.ini
    environment:
      - COUCHDB_USER=<USER>
      - COUCHDB_PASSWORD=<PASSWORD>

volumes:
  couchdb_data:
```
CouchDB Configuration file couchdb.ini file for additional CouchDB settings:
```ini
[couchdb]
single_node = true
max_document_size = 50000000

[chttpd]
require_valid_user = true
bind_address = any
max_http_request_size = 4294967296

[chttpd_auth]
require_valid_user = true
authentication_redirect = /_utils/session.html

[httpd]
WWW-Authenticate = Basic realm="couchdb"
enable_cors = true

[cors]
origins = *
credentials = true
headers = accept, authorization, content-type, origin, referer
methods = GET, PUT, POST, HEAD, DELETE
max_age = 3600

```

### Accessing the Application

Once the containers are running, open your web browser and go to `http://localhost:3000` to access Nomie6 OSS.

## Configuration

- **Data Persistence:** The CouchDB setup includes a named volume `couchdb_data` to ensure data persists across container restarts.
- **CouchDB Configuration:** Modify the `couchdb.ini` file if additional CouchDB settings are required.

## Contributing to This Repository

If you would like to contribute to this Docker setup, please follow these guidelines:

- **Issues:** Report any issues or bugs [here](https://github.com/rogerrum/docker-nomie6-oss/issues).
- **Pull Requests:** Submit pull requests for improvements or fixes via the GitHub interface.

## Contributing to the Original Nomie6 OSS Repository

For contributions or feedback related to the Nomie6 OSS application itself, please refer to the original [Nomie6 OSS repository](https://github.com/open-nomie/nomie6-oss):

- **Issues:** Report issues or suggest features [here](https://github.com/open-nomie/nomie6-oss/issues).
- **Pull Requests:** Contribute to the Nomie6 OSS application by submitting pull requests via their GitHub interface.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact
For questions or issues, please open an issue on GitHub.

