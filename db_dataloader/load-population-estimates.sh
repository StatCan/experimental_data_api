#!/bin/sh
source fn.sh
source sgc.sh

cube=17100009
template='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $8) gsub(/v/, "", $8) gsub(/"/, "", $10) }; \
'$(get_sgc 2)' \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_name varchar = \x27population\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01\x27, "$10") INTO observation_id_val; \
    \
    PERFORM add_vector ("$8", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
  END; $$;"\
}'

run_query ${cube} "${template}"
