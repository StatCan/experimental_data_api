#!/bin/sh
if [ "$(psql -At -c 'SELECT COUNT(*) FROM observations')" -eq 0 ]; then
  echo "Loading data" \
  && ./load-subjects.sh \
  && ./load-frequencies.sh \
  && ./load-status.sh \
  && ./load-dimensions.sh \
  && time ./load-population-estimates.sh \
  && time ./load-air-fare.sh \
  && time ./load-cpi.sh \
  && echo "Loading complete"
fi
