#!/bin/sh
source fn.sh

cube=17100040
template='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $2) gsub(/"/, "", $4) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) }; \
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
{ gsub(/Returning emigrants/, "emigrants_returning", $4) } \
{ gsub(/Net temporary emigrants/, "emigrants_temporary_net", $4) } \
{ gsub(/Net non-permanent residents/, "non_permanent_residents_net", $4) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_id_val integer; \
    observation_id_val integer; \
  BEGIN \
    SELECT id INTO indicator_id_val FROM indicators WHERE name = \x27"tolower($4)"\x27; \
    \
    INSERT INTO observations (id, indicator_id, period) \
    VALUES(DEFAULT, indicator_id_val, TO_DATE(\x27"$1"-01\x27, \x27YYYY-MM-DD\x27)) \
    RETURNING id INTO observation_id_val; \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_values (observation_id, date, value) \
    VALUES(observation_id_val, NOW(), "$11"); \
    \
    IF NOT EXISTS (SELECT * FROM vectors WHERE id = "$9") THEN \
      INSERT INTO vectors (id, indicator_id, dimensions) \
      VALUES ("$9", indicator_id_val, ( \
        SELECT dimensions FROM observation_dimensions WHERE observation_id = observation_id_val) - \x27period\x27::text \
      ); \
    END IF; \
  END; $$;"\
}'
run_query ${cube} "${template}"
