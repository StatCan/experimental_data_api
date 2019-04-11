INSERT INTO indicators (name, sdmx_id, frequency_id, title)
VALUES
(
  'population', 'DEM_POP', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Population Estimates'], ['fr', '']])
),
(
  'births', 'DEM_LVB', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Births'], ['fr', 'Naissances']])
),
(
  'deaths', 'DEM_DTH', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Deaths'], ['fr', 'Décès']])
),
(
  'immigrants', 'DEM_IMM', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Immigrants'], ['fr', 'Immigrants']])
),
(
  'emigrants', 'DEM_EMI', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Emigrants'], ['fr', 'Émigrants']])
),
(
  'emigrants_returning', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Returning emigrants'], ['fr', '']])
),
(
  'emigrants_temporary_net', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Net temporary emigrants'], ['fr', '']])
),
(
  'non_permanent_residents_net', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Net non-permanent residents'], ['fr', '']])
);

DO $$
DECLARE
  ind varchar;
  dim varchar;
BEGIN
FOREACH ind IN ARRAY ARRAY['population', 'births', 'deaths', 'immigrants', 'emigrants', 'emigrants_returning', 'emigrants_temporary_net', 'non_permanent_residents_net']
LOOP
  FOREACH dim IN ARRAY ARRAY['geographicArea']
  LOOP
    INSERT INTO indicator_dimensions (indicator_id, dimension_id)
    VALUES (
      (SELECT id FROM indicators WHERE name = ind),
      (SELECT id FROM dimensions WHERE name = dim)
    );
  END LOOP;
END LOOP;
END; $$;

INSERT INTO indicators (name, frequency_id, title)
VALUES
(
  'airFares', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', ''], ['fr', '']])
);

DO $$
DECLARE
  ind varchar = 'airFares';
  dim varchar;
BEGIN
FOREACH dim IN ARRAY ARRAY['geographicArea', 'flightSector', 'airFareTypeGroup']
LOOP
  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    (SELECT id FROM indicators WHERE name = ind),
    (SELECT id FROM dimensions WHERE name = dim)
  );
END LOOP;
END; $$
