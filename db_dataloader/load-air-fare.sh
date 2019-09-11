#!/bin/sh
source fn.sh
source sgc.sh

echo "Creating airfaire indicator"
psql -c 'INSERT INTO indicators (name, frequency_id, title)
VALUES
(
  '"'"'airFares'"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"''"'"'], ['"'"'fr'"'"', '"'"''"'"']])
);

DO $$
DECLARE
  ind varchar = '"'"'airFares'"'"';
  dim varchar;
BEGIN
FOREACH dim IN ARRAY ARRAY['"'"'geographicArea'"'"', '"'"'flightSector'"'"', '"'"'airFareTypeGroup'"'"']
LOOP
  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    (SELECT id FROM indicators WHERE name = ind),
    (SELECT id FROM dimensions WHERE name = dim)
  );
END LOOP;

INSERT INTO indicator_subjects (indicator_id, subject_id)
VALUES (
  (SELECT id FROM indicators WHERE name = ind),
  (SELECT id FROM subjects WHERE name = '"'"'transportation'"'"')
);
END; $$'

cube=23100036
template='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $4) gsub(/"/, "", $5) gsub(/"/, "", $10) gsub(/v/, "", $10) gsub(/""/, "NULL", $12) gsub(/"/, "", $12) gsub(/"/, "", $13) }; \
'$(get_sgc 2)' \
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
    indicator_name varchar = \x27airFares\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (indicator_name, \x27"$1"-01\x27, "$12", \x27"$13"\x27) INTO observation_id_val; \
    \
    PERFORM add_vector ("$10", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_flightSector (observation_id, value) \
    VALUES(observation_id_val, \x27"$4"\x27); \
    \
    INSERT INTO observation_dimension_airFareTypeGroup (observation_id, value) \
    VALUES(observation_id_val, \x27"$5"\x27); \
  END; $$;"\
}'
run_query ${cube} "${template}"

cube2=23100237
template2='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $8) gsub(/v/, "", $8) gsub(/""/, "NULL", $10) gsub(/"/, "", $10) gsub(/"/, "", $11) }; \
'$(get_sgc 2)' \
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
    indicator_name varchar = \x27airFares\x27; \
    observation_id_val integer; \
  BEGIN \
    SELECT add_observation (\x27airFares\x27, \x27"$1"-01\x27, "$10", \x27"$11"\x27) INTO observation_id_val; \
    \
    PERFORM add_vector ("$8", observation_id_val); \
    \
    INSERT INTO observation_dimension_geographicArea (observation_id, value) \
    VALUES(observation_id_val, \x27"$2"\x27); \
    \
    INSERT INTO observation_dimension_flightSector (observation_id, value) \
    VALUES(observation_id_val, \x27domestic\x27); \
    \
    INSERT INTO observation_dimension_airFareTypeGroup (observation_id, value) \
    VALUES(observation_id_val, \x27all\x27); \
  END; $$;"\
}'
run_query ${cube2} "${template2}"
