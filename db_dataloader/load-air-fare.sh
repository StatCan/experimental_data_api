#!/bin/sh
source fn.sh

cube=23100036
template='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $2) gsub(/"/, "", $4) gsub(/"/, "", $5) gsub(/"/, "", $10) gsub(/v/, "", $10) gsub(/""/, "NULL", $12) gsub(/"/, "", $12) gsub(/"/, "", $13) }; \
{ gsub(/Canada/, "01", $2) } \
{ gsub(/Domestic and international/, "domestic_and_international", $4) } \
{ gsub(/Domestic/, "domestic", $4) } \
{ gsub(/Short-haul/, "shortHaul", $4) } \
{ gsub(/Long-haul/, "longHaul", $4) } \
{ gsub(/International/, "international", $4) } \
{ gsub(/All fare groups/, "all", $5) } \
{ gsub(/Business class/, "business", $5) } \
{ gsub(/Economy/, "economy", $5) } \
{ gsub(/Discounted/, "discounted", $5) } \
{ gsub(/Other fares/, "other", $5) } \
NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_id_val integer; \
    observation_id_val integer; \
    observation_value_id_val integer; \
  BEGIN \
    SELECT id INTO indicator_id_val FROM indicators WHERE name = \x27airFares\x27; \
    \
    INSERT INTO observations (id, indicator_id, period) \
    VALUES(DEFAULT, indicator_id_val, TO_DATE(\x27"$1"-01\x27, \x27YYYY-MM-DD\x27)) \
    RETURNING id INTO observation_id_val; \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_flightSector (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
    \
    INSERT INTO observation_dimension_airFareTypeGroup (observation_id, value) \
    VALUES(observation_id_val, \x27"$5"\x27); \
    \
    INSERT INTO observation_values (observation_id, date, value) \
    VALUES(observation_id_val, NOW(), "$12") \
    RETURNING id INTO observation_value_id_val; \
    \
    IF NOT \x27"$13"\x27 = \x27\x27 THEN \
      INSERT INTO observation_status (observation_value_id, observation_status_id) \
      VALUES(\
        observation_value_id_val, \
        (SELECT id FROM status WHERE symbol = \x27"$13"\x27) \
      ); \
    END IF; \
    \
    IF NOT EXISTS (SELECT * FROM vectors WHERE id = "$10") THEN \
      INSERT INTO vectors (id, indicator_id, dimensions) \
      VALUES ("$10", indicator_id_val, ( \
        SELECT dimensions FROM observation_dimensions WHERE observation_id = observation_id_val) - \x27period\x27::text \
      ); \
    END IF; \
  END; $$;"\
}'
run_query ${cube} "${template}"

cube2=23100237
template2='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $2) gsub(/"/, "", $8) gsub(/v/, "", $8) gsub(/""/, "NULL", $10) gsub(/"/, "", $10) gsub(/"/, "", $11) }; \
{ gsub(/Halifax/, "205", $2) } \
{ gsub(/Montréal/, "462", $2) } \
{ gsub(/Ottawa/, "3506008", $2) } \
{ gsub(/Toronto/, "535", $2) } \
{ gsub(/Winnipeg/, "602", $2) } \
{ gsub(/Saskatoon/, "725", $2) } \
{ gsub(/Regina/, "705", $2) } \
{ gsub(/Calgary/, "825", $2) } \
{ gsub(/Edmonton/, "835", $2) } \
{ gsub(/Vancouver/, "933", $2) } \
/Canada/ {print "\
  DO $$ \
  BEGIN \
    IF NOT EXISTS (SELECT * FROM vectors_duplicate WHERE id = "$8") THEN \
      INSERT INTO vectors_duplicate (id, vector_id) \
      VALUES ("$8", 53508622); \
    END IF; \
  END; $$;" \
} \
!/Canada/ && NR > 2 { print "\
  DO $$ \
  DECLARE \
    indicator_id_val integer; \
    observation_id_val integer; \
    observation_value_id_val integer; \
  BEGIN \
    SELECT id INTO indicator_id_val FROM indicators WHERE name = \x27airFares\x27; \
    \
    INSERT INTO observations (id, indicator_id, period) \
    VALUES(DEFAULT, indicator_id_val, TO_DATE(\x27"$1"-01\x27, \x27YYYY-MM-DD\x27)) \
    RETURNING id INTO observation_id_val; \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_flightSector (observation_id, value) \
    VALUES(observation_id_val, \x27domestic\x27); \
    \
    INSERT INTO observation_dimension_airFareTypeGroup (observation_id, value) \
    VALUES(observation_id_val, \x27all\x27); \
    \
    INSERT INTO observation_values (observation_id, date, value) \
    VALUES(observation_id_val, NOW(), "$10") \
    RETURNING id INTO observation_value_id_val; \
    \
    IF NOT \x27"$11"\x27 = \x27\x27 THEN \
      INSERT INTO observation_status (observation_value_id, observation_status_id) \
      VALUES(\
        observation_value_id_val, \
        (SELECT id FROM status WHERE symbol = \x27"$11"\x27) \
      ); \
    END IF; \
    \
    IF NOT EXISTS (SELECT * FROM vectors WHERE id = "$8") THEN \
      INSERT INTO vectors (id, indicator_id, dimensions) \
      VALUES ("$8", indicator_id_val, ( \
        SELECT dimensions FROM observation_dimensions WHERE observation_id = observation_id_val) - \x27period\x27::text \
      ); \
    END IF; \
  END; $$;"\
}'
run_query ${cube2} "${template2}"
