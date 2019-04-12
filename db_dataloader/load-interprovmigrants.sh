#!/bin/sh
source fn.sh

cube=17100045
template='BEGIN \
{ FS="\",\"" } \
{ gsub(/, province of origin/, "") gsub(/, province of destination/, "")  }
{ gsub(/, province of origin/, "") }\
{ FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $2) gsub(/"/, "", $4) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) }; \
{ gsub(/Canada/, "01", $2) } \
{ gsub(/Canada/, "01", $4) } \
{ gsub(/Newfoundland and Labrador/, "10", $2) } \
{ gsub(/Newfoundland and Labrador/, "10", $4) } \
{ gsub(/Prince Edward Island/, "11", $2) } \
{ gsub(/Prince Edward Island/, "11", $4) } \
{ gsub(/Nova Scotia/, "12", $2) } \
{ gsub(/Nova Scotia/, "12", $4) } \
{ gsub(/New Brunswick/, "13", $2) } \
{ gsub(/New Brunswick/, "13", $4) } \
{ gsub(/Quebec/, "24", $2) } \
{ gsub(/Quebec/, "24", $4) } \
{ gsub(/Ontario/, "35", $2) } \
{ gsub(/Ontario/, "35", $4) } \
{ gsub(/Manitoba/, "46", $2) } \
{ gsub(/Manitoba/, "46", $4) } \
{ gsub(/Saskatchewan/, "47", $2) } \
{ gsub(/Saskatchewan/, "47", $4) } \
{ gsub(/Alberta/, "48", $2) } \
{ gsub(/Alberta/, "48", $4) } \
{ gsub(/British Columbia/, "59", $2) } \
{ gsub(/British Columbia/, "59", $4) } \
{ gsub(/Yukon/, "60", $2) } \
{ gsub(/Yukon/, "60", $4) } \
{ gsub(/Northwest Territories including Nunavut/, "61", $2) } \
{ gsub(/Northwest Territories including Nunavut/, "61", $4) } \
{ gsub(/Northwest Territories/, "61", $2) } \
{ gsub(/Northwest Territories/, "61", $4) } \
{ gsub(/Nunavut/, "62", $2) } \
{ gsub(/Nunavut/, "62", $4) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_id_val integer; \
    observation_id_val integer; \
  BEGIN \
    SELECT id INTO indicator_id_val FROM indicators WHERE name = \x27interprovincial_migrants\x27; \
    \
    INSERT INTO observations (id, indicator_id, period) \
    VALUES(DEFAULT, indicator_id_val, TO_DATE(\x27"$1"-01\x27, \x27YYYY-MM-DD\x27)) \
    RETURNING id INTO observation_id_val; \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_geographicArea_provinceDestination (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
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
