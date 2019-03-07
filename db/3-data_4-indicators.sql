INSERT INTO indicators (name, sdmx_id, frequency_id, title)
VALUES
(
  'population', 'DEM_POP', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Population Estimates'], ['fr', '']])
),
(
  'birth', 'DEM_LVB', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Birth'], ['fr', 'Naissances']])
),
(
  'death', 'DEM_DTH', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Deaths'], ['fr', 'Décès']])
),
(
  'immigration', 'DEM_IMM', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Immigration'], ['fr', 'Immigration']])
),
(
  'emigration', 'DEM_EMI', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Emigration'], ['fr', 'Émigration']])
);

DO $$
DECLARE
  ind varchar;
  dim varchar;
BEGIN
FOREACH ind IN ARRAY ARRAY['population', 'birth', 'death', 'immigration', 'emigration']
LOOP
  FOREACH dim IN ARRAY ARRAY['period', 'geographicArea']
  LOOP
    INSERT INTO indicator_dimensions (indicator_id, dimension_id)
    VALUES (
      (SELECT id FROM indicators WHERE name = ind),
      (SELECT id FROM dimensions WHERE name = dim)
    );
  END LOOP;
END LOOP;
END; $$
