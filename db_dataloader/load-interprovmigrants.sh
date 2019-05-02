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
    indicator_name varchar = \x27interprovincial_migrants\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01\x27, "$11") INTO observation_id_val; \
    \
    PERFORM add_vector ("$9", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_geographicArea_provinceDestination (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
  END; $$;"\
}'
run_query ${cube} "${template}"
