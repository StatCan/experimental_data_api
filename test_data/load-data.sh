#!/bin/sh
if [ "$(psql -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  echo "Loading data" \
  && psql -q1 -v ON_ERROR_STOP=1 -f ./test_data.sql \
  && echo "Loading complete"
fi
