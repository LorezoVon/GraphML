FROM postgres:16

ENV PGDATA=/var/lib/postgresql/data

# Install required packages during build
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*

# Optimize PostgreSQL for large datasets and bulk loading
RUN echo "shared_buffers=2GB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "work_mem=32MB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "maintenance_work_mem=2GB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "wal_buffers=512MB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "max_wal_size=16GB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "min_wal_size=4GB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "checkpoint_timeout=30min" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "checkpoint_completion_target=0.9" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "max_parallel_workers_per_gather=4" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "effective_cache_size=4GB" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "synchronous_commit=off" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "autovacuum=off" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "fsync=off" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "full_page_writes=off" >> /usr/share/postgresql/postgresql.conf.sample

COPY init-db.sh /docker-entrypoint-initdb.d/init-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh
