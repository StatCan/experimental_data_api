#!/bin/sh
if [ "$(psql -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  echo "Loading data" \
  && time ./load-population-estimates.sh \
  && time ./load-birth-death.sh \
  && time ./load-migrants.sh \
  && time ./load-interprovmigrants.sh \
  && time ./load-air-fare.sh \
  && time ./load-cpi.sh \
  && echo "Loading complete"
fi
