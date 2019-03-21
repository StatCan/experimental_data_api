#!/bin/sh
run_query () {
  cube=$1;
  shift
  template="$1"

echo "Loading ${cube}..." \
    && wget -qnc https://www150.statcan.gc.ca/n1/tbl/csv/${cube}-eng.zip \
    && unzip -q ${cube}-eng.zip ${cube}.csv \
    && awk "$template" "${cube}.csv" >> "${cube}.csv.sql" \
    && (cat "${cube}.csv.sql" | psql -q) \
    && rm  \
      "${cube}-eng.zip" \
      "${cube}.csv" \
      "${cube}.csv.sql" \
    && echo "Done loading ${cube}"
}
