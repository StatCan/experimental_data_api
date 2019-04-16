#!/bin/sh
source fn.sh
source sgc.sh
source cpi.sh

cube=18100006
template='BEGIN \
{ FS="\",\"" } \
{ gsub(/ \(1992=100\)/, "") gsub(/ \(2002=100\)/, "") gsub(/ \(200212=100\)/, "") gsub(/ \(200704=100\)/, "") gsub(/ \(201104=100\)/, "") gsub(/ \(2013=100\)/, "") } \
{ gsub(/, /, " ") } \
{ gsub(/=100/, "")  } \
{ FS="," } \
{ gsub(/"/, "", $1) gsub(/"/, "", $5) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) } \
'$(get_sgc 2)' \
'$(get_cpi 4)' \
{ $5 = gensub(/(\d{4})(\d{2})/, "\\1-\\2", "g", $5); $5 = gensub(/(\d{4})/, "\\1-01", "g", $5) } \
{ gsub(/\x27/, "", $4) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_name varchar = \x27consumer_price_index\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01\x27, "$11") INTO observation_id_val; \
    \
    PERFORM add_vector ("$9", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_consumerPriceProduct (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
    \
    INSERT INTO observation_dimension_priceBaseDate (observation_id, value) \
    VALUES(observation_id_val, TO_DATE(\x27"$5"-01\x27, \x27YYYY-MM-DD\x27)); \
    \
    INSERT INTO observation_dimension_seasonallyAdjusted (observation_id, value) \
    VALUES(observation_id_val, TRUE); \
  END; $$;"\
}'
run_query ${cube} "${template}"

cube=18100004
template='BEGIN \
{ FS="\",\"" } \
{ gsub(/ \(1992=100\)/, "") gsub(/ \(2002=100\)/, "") gsub(/ \(200212=100\)/, "") gsub(/ \(200704=100\)/, "") gsub(/ \(201104=100\)/, "") gsub(/ \(2013=100\)/, "") } \
{ gsub(/, /, " ") } \
{ gsub(/=100/, "")  } \
{ FS="," } \
{ gsub(/"/, "", $1) gsub(/"/, "", $5) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) } \
'$(get_sgc 2)' \
'$(get_cpi 4)' \
{ $5 = gensub(/(\d{4})(\d{2})/, "\\1-\\2", "g", $5); $5 = gensub(/(\d{4})/, "\\1-01", "g", $5) } \
{ gsub(/\x27/, "", $4) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_name varchar = \x27consumer_price_index\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01\x27, "$11") INTO observation_id_val; \
    \
    PERFORM add_vector ("$9", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_consumerPriceProduct (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
    \
    INSERT INTO observation_dimension_priceBaseDate (observation_id, value) \
    VALUES(observation_id_val, TO_DATE(\x27"$5"-01\x27, \x27YYYY-MM-DD\x27)); \
    \
    INSERT INTO observation_dimension_seasonallyAdjusted (observation_id, value) \
    VALUES(observation_id_val, FALSE); \
  END; $$;"\
}'
#run_query ${cube} "${template}"

cube=18100007
template='BEGIN \
{ FS="\",\"" } \
{ gsub(/, /, " ") } \
{ FS="," } \
{ gsub(/"/, "", $1) gsub(/"/, "", $5) gsub(/"/, "", $6) gsub(/"/, "", $11) gsub(/v/, "", $11) gsub(/"/, "", $13) gsub(/"/, "", $14) } \
'$(get_sgc 2)' \
'$(get_cpi 4)' \
{ gsub(/Weight at basket link month prices/, "linkMonth", $5) } \
{ gsub(/Weight at basket reference period prices/, "referencePeriod", $5) } \
{ gsub(/Distribution to Canada/, "toCanada", $6) } \
{ gsub(/Distribution to selected geographies/, "toSelectedGeographies", $6) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_name varchar = \x27consumer_price_weight\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01-01\x27, "$13/100", \x27"$14"\x27) INTO observation_id_val; \
    \
    PERFORM add_vector ("$11", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_consumerPriceProduct (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
    \
    INSERT INTO observation_dimension_weightPricePeriod (observation_id, value) \
    VALUES(observation_id_val, \x27"$5"\x27); \
    \
    INSERT INTO observation_dimension_weightGeographicDistribution (observation_id, value) \
    VALUES(observation_id_val, \x27"$6"\x27); \
  END; $$;"\
}'
run_query ${cube} "${template}"
