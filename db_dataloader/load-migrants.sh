#!/bin/sh
source fn.sh
source sgc.sh

cube=17100040
template='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $4) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) }; \
'$(get_sgc 2)' \
{ gsub(/Returning emigrants/, "emigrants_returning", $4) } \
{ gsub(/Net temporary emigrants/, "emigrants_temporary_net", $4) } \
{ gsub(/Net non-permanent residents/, "non_permanent_residents_net", $4) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_name varchar = \x27"tolower($4)"\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01\x27, "$11") INTO observation_id_val; \
    \
    PERFORM add_vector ("$9", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
  END; $$;"\
}'
run_query ${cube} "${template}"
