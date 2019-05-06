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

INSERT INTO indicator_subjects (indicator_id, subject_id)
VALUES (
  (SELECT id FROM indicators WHERE name = ind),
  (SELECT id FROM subjects WHERE name = 'transportation')
);
END; $$
