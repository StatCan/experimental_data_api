#!/bin/sh

run_query () {
  file=$1;
  template='BEGIN { FS="," }\
  { gsub(/"/, "", $1) gsub(/"/, "", $2) gsub(/"/, "", $8) gsub(/v/, "", $8) gsub(/"/, "", $10) }; \
  { gsub(/Canada/, "01", $2) } \
  { gsub(/Newfoundland and Labrador/, "10", $2) } \
  { gsub(/Prince Edward Island/, "11", $2) } \
  { gsub(/Nova Scotia/, "12", $2) } \
  { gsub(/New Brunswick/, "13", $2) } \
  { gsub(/Quebec/, "24", $2) } \
  { gsub(/Ontario/, "35", $2) } \
  { gsub(/Manitoba/, "46", $2) } \
  { gsub(/Saskatchewan/, "47", $2) } \
  { gsub(/Alberta/, "48", $2) } \
  { gsub(/British Columbia/, "59", $2) } \
  { gsub(/Yukon/, "60", $2) } \
  { gsub(/Northwest Territories including Nunavut/, "61", $2) } \
  { gsub(/Northwest Territories/, "61", $2) } \
  { gsub(/Nunavut/, "62", $2) } \
  NR > 2 { print "\
    DO $$ \
    DECLARE \
      indicator_id_val integer; \
      observation_id_val integer; \
    BEGIN \
      SELECT id INTO indicator_id_val FROM indicators WHERE name = \x27population\x27; \
      \
      INSERT INTO observations (id, indicator_id) \
      VALUES(DEFAULT, indicator_id_val) \
      RETURNING id INTO observation_id_val; \
      \
      INSERT INTO observation_dimension_period (observation_id, value) \
      VALUES(observation_id_val, TO_DATE(\x27"$1"-01\x27, \x27YYYY-MM-DD\x27)); \
      \
      INSERT INTO observation_dimension_geographicArea (observation_id, value) \
      VALUES(observation_id_val, \x27"$2"\x27); \
      \
      INSERT INTO observation_values (observation_id, date, value) \
      VALUES(observation_id_val, NOW(), "$10"); \
      \
      IF NOT EXISTS (SELECT * FROM vectors WHERE id = "$8") THEN \
        INSERT INTO vectors (id, indicator_id, dimensions) \
        VALUES ("$8", indicator_id_val, ( \
          SELECT dimensions FROM observation_dimensions WHERE observation_id = observation_id_val) - \x27period\x27::text \
        ); \
      END IF; \
    END; $$;"\
  }'

  awk "$template" $file | psql -h "$PGHOST" -d "$POSTGRES_DB" -U postgres
}

wget https://www150.statcan.gc.ca/n1/tbl/csv/17100009-eng.zip \
  && unzip 17100009-eng.zip 17100009.csv \
  && run_query "17100009.csv" \
  && rm 17100009-eng.zip 17100009.csv \
