#!/bin/sh
if [ "$(psql -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  echo "Loading data" \
  && ./load-population-estimates.sh \
  && ./load-birth-death.sh \
  && ./load-migrants.sh \
  && ./load-air-fare.sh \
  && echo "Loading complete"
fi
