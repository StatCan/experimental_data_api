#!/bin/sh
source fn.sh
source sgc.sh

echo "Creating population estimates indicator"
psql -q -c 'INSERT INTO indicators (name, sdmx_id, frequency_id, title)
VALUES
(
  '"'"'population'"'"', '"'"'DEM_POP'"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Population Estimates'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'births'"'"', '"'"'DEM_LVB'"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Births'"'"'], ['"'"'fr'"'"', '"'"'Naissances'"'"']])
),
(
  '"'"'deaths'"'"', '"'"'DEM_DTH'"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Deaths'"'"'], ['"'"'fr'"'"', '"'"'Décès'"'"']])
),
(
  '"'"'immigrants'"'"', '"'"'DEM_IMM'"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Immigrants'"'"'], ['"'"'fr'"'"', '"'"'Immigrants'"'"']])
),
(
  '"'"'emigrants'"'"', '"'"'DEM_EMI'"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Emigrants'"'"'], ['"'"'fr'"'"', '"'"'Émigrants'"'"']])
),
(
  '"'"'emigrants_returning'"'"', '"'"''"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Returning emigrants'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'emigrants_temporary_net'"'"', '"'"''"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Net temporary emigrants'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'non_permanent_residents_net'"'"', '"'"''"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Net non-permanent residents'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'interprovincial_migrants'"'"', '"'"''"'"', (SELECT id FROM frequencies WHERE name = '"'"'quarterly'"'"'),
  hstore(ARRAY[['"'"'en'"'"', '"'"'Interprovincial Migrants'"'"'], ['"'"'fr'"'"', '"'"'Migrant Interprovinciaux'"'"']])
);

DO $$
DECLARE
  ind varchar;
  dim varchar;
BEGIN
FOREACH ind IN ARRAY ARRAY['"'"'population'"'"', '"'"'births'"'"', '"'"'deaths'"'"', '"'"'immigrants'"'"', '"'"'emigrants'"'"', '"'"'emigrants_returning'"'"', '"'"'emigrants_temporary_net'"'"', '"'"'non_permanent_residents_net'"'"']
LOOP
  FOREACH dim IN ARRAY ARRAY['"'"'geographicArea'"'"']
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
    (SELECT id FROM subjects WHERE name = '"'"'population_and_demography'"'"')
  );
END LOOP;
END; $$;

DO $$
DECLARE
  ind varchar = '"'"'interprovincial_migrants'"'"';
  dim varchar;
BEGIN
FOREACH dim IN ARRAY ARRAY['"'"'geographicArea'"'"', '"'"'geographicArea_provinceDestination'"'"']
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
  (SELECT id FROM subjects WHERE name = '"'"'population_and_demography'"'"')
);
END; $$;'

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

cube=17100059
template='BEGIN { FS="," }\
{ gsub(/"/, "", $1) gsub(/"/, "", $4) gsub(/"/, "", $9) gsub(/v/, "", $9) gsub(/"/, "", $11) }; \
'$(get_sgc 2)' \
/Marriage/ {print ""} \
!/Marriage/ && NR > 2 { print "\
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
