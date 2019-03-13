#!/bin/sh
if [ "$(psql -h "$PGHOST" -d "$POSTGRES_DB" -U postgres -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  ./load-population-estimates.sh \
  && ./load-birth-death.sh
fi
