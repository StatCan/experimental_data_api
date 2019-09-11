#!/bin/sh
# wait-for-postgres.sh

set -e

cmd="$@"

until psql -c '\q' 2> /dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

sleep 5

>&2 echo "Postgres is up - executing command"
exec $cmd
