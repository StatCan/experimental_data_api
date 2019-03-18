#!/bin/sh
if [ "$(psql -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  ./load-population-estimates.sh \
  && ./load-birth-death.sh \
  && ./load-migrants.sh
fi
