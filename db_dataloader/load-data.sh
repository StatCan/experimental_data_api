#!/bin/sh
if [ "$(psql -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  echo "Loading data" \
  && psql -q -f ./subjects.sql \
  && psql -q -f ./frequencies.sql \
  && psql -q -f ./status.sql \
  && psql -q -f ./dimensions.sql \
  && psql -q -f ./types.sql \
  && psql -q -f ./population_estimates.sql \
  && psql -q -f ./air_fare.sql \
  && psql -q -f ./vector_duplicates.sql \
  && echo "Loading complete"
fi
