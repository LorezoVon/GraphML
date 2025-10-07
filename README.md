# Bitcoin Temporal Graph Database

This project provides a PostgreSQL database setup for analyzing Bitcoin transaction networks as temporal graphs. The database is optimized for handling large-scale graph data with efficient querying capabilities.

## Prerequisites

- Docker and Docker Compose
- At least 64GB of free disk space
- Minimum 8GB RAM (16GB recommended)
- The Bitcoin graph dataset files (should be placed in the `dataset/` directory)

## Dataset Structure

Place the following files in the `dataset/` directory:
- `3617.dat` - Transaction edges data
- `3618.dat` - Node features data
- `toc.dat` - Table of contents for the database dump

Note: These files are gitignored and need to be obtained separately.

## Quick Start

1. **Prepare the Environment**
   ```bash
   # Ensure correct permissions
   chmod -R 644 dataset/*.dat
   chmod 755 dataset/
   ```

2. **Start the Database**
   ```bash
   # Build and start the PostgreSQL container
   docker-compose up --build
   ```


3. **Connect to the Database**
   ```bash
   # Connect using psql (from another terminal)
   docker exec -it bitcoin_graph_db psql -U bitcoin -d bitcoin
   
   # Or connect from your host machine
   psql -h localhost -p 5432 -U bitcoin -d bitcoin
   ```

   Connection details:
   - Host: localhost
   - Port: 5432
   - Database: bitcoin
   - Username: bitcoin
   - Password: bitcoin

## Database Schema

### Tables

1. **node_features**
   - Contains features and properties of Bitcoin addresses/nodes

2. **transaction_edges**
   - Represents Bitcoin transactions as temporal edges in the graph
   - Each edge includes timestamp and transaction value information

## Configuration

The PostgreSQL instance is optimized for handling large datasets with the following configurations:
- Shared buffers: 2GB
- Work memory: 32MB per operation
- Maintenance work memory: 2GB
- WAL buffers: 512MB
- Maximum WAL size: 16GB
- Parallel query workers: 4

These settings can be adjusted in the `Dockerfile` if needed.

## Troubleshooting

### Common Issues

1. **Permission Errors**
   ```bash
   # Fix dataset permissions
   chmod -R 644 dataset/*.dat
   chmod 755 dataset/
   ```

2. **Memory Issues**
   - Ensure your Docker has enough memory allocated
   - Consider increasing the `shared_buffers` and `work_mem` in the Dockerfile

3. **Slow Import**
   - The initial import might take several hours depending on your hardware
   - Progress can be monitored in the Docker logs

