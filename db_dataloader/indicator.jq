. | "
DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      '\(.id)', '\(.sdmx_id)', (SELECT id FROM frequencies WHERE name = '\(.frequency)'),
      hstore(ARRAY[['en', '\(.title.en)'], ['fr', '\(.title.fr)']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  " + ([.subjects[] | "
  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = '\(.)')
  );
  "] | join("")) + "

  " + ([[.timeseries[] | .dimensions | to_entries[] | .key] | unique[] | "
  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = '\(.)')
  );
  "] | join("")) + "

  " + ([.timeseries[] | "

  DECLARE
    timeseries UUID := '[UUID_HERE]';
    vector integer := \(.vector_id);
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    " + ([.dimensions | to_entries[] | "
    INSERT INTO timeseries_dimension_\(.key) (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_\(.key) WHERE name = '\(.value)'));
    "] | join("")) + "
  END;"] | join("")) + "
END; $$;"
