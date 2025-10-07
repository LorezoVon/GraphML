#!/bin/bash
set -e

cleanup_database() {
    echo "🧹 Cleaning up database..."
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "DROP TABLE IF EXISTS node_features CASCADE;"
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "DROP TABLE IF EXISTS transaction_edges CASCADE;"
    echo "✅ Database cleaned successfully"
}

# Check if cleanup flag is passed
if [ "$1" = "cleanup" ]; then
    cleanup_database
    exit 0
fi

# Wait for PostgreSQL to be ready
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"
do
  echo "🕒 Waiting for PostgreSQL to start..."
  sleep 2
done

echo "📦 Restoring Bitcoin Temporal Graph dataset..."

# Ensure the dataset directory is readable
if [ ! -r "/dataset/toc.dat" ]; then
    echo "❌ Error: Cannot read /dataset/toc.dat"
    exit 1
fi

# Perform the restore without host specification to use Unix socket
pg_restore -j 4 -Fd -O -U bitcoin -d bitcoin dataset

echo "✅ Dataset restoration complete."
