#!/bin/sh
source fn.sh
source sgc.sh

cube=17100045
template='BEGIN \
{ FS="\",\"" } \
{ gsub(/, province of origin/, "") gsub(/, province of destination/, "")  }
{ gsub(/, province of origin/, "") }\
{ FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) }; \
'$(get_sgc 2)' \
'$(get_sgc 4)' \
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
