CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DO $$
DECLARE
  tables varchar[] := array[
  'observation_values',
  'vectors',
  'observation_dimension_geographicArea',
  'observation_dimension_seasonallyAdjusted',
  'observation_dimension_geographicArea_provinceDestination',
  'observation_dimension_consumerPriceProduct',
  'observation_dimension_priceBaseDate',
  'observation_dimension_weightPricePeriod',
  'observation_dimension_weightGeographicDistribution',
  'observation_dimension_sex',
  'observation_dimension_flightSector',
  'observation_dimension_airFareTypeGroup'
  ];
  tbl varchar;
BEGIN
  ALTER TABLE observations RENAME COLUMN id TO id_old;
  ALTER TABLE observations ADD COLUMN id UUID DEFAULT uuid_generate_v4();

  FOREACH tbl IN ARRAY tables
  LOOP
    EXECUTE format('ALTER TABLE %s RENAME COLUMN observation_id TO observation_id_old', tbl);
    EXECUTE format('ALTER TABLE %s ADD COLUMN observation_id UUID', tbl);
    EXECUTE format('UPDATE %s SET observation_id = observations.id FROM observations WHERE %s.observation_id_old = observations.id_old', tbl, tbl);
  END LOOP;

  ALTER VIEW "vIndicators" RENAME TO "vIndicators_old";
  CREATE VIEW "vIndicators" AS
    WITH last_modified AS (
      SELECT
        indicator_id, MAX(date) AS dateModified
      FROM observations o
      INNER JOIN observation_values v ON o.id = v.observation_id
      GROUP BY indicator_id
    ), dimensions AS (
      SELECT
        indicator_id, ARRAY_AGG(d.name) as dimensions
      FROM dimensions d
      INNER JOIN indicator_dimensions id ON d.id = id.dimension_id
      GROUP BY indicator_id
    ), period AS (
      SELECT
        indicator_id, MIN(period) AS min, MAX(period) AS max
      FROM observations o
      GROUP BY indicator_id
    )
    SELECT
      i.name as id, i.sdmx_id AS "sdmxId", i.title::jsonb, f.name AS frequency, (p.min || '/' || p.max) AS "temporalCoverage", dimensions, m.dateModified AS "dateModified"
    FROM indicators i
    INNER JOIN frequencies f ON i.frequency_id = f.id
    INNER JOIN dimensions d ON i.id = d.indicator_id
    LEFT JOIN last_modified m ON i.id = m.indicator_id
    LEFT JOIN period p ON i.id = p.indicator_id;

  ALTER MATERIALIZED VIEW "mvObservationsDimensions" RENAME TO "mvObservationsDimensions_old";

  CREATE MATERIALIZED VIEW "mvObservationsDimensions" AS
  SELECT
    o.id observation_id,
    jsonb_strip_nulls(jsonb_build_object(
      'geographicArea', ga.value,
      'seasonallyAdjusted', sa.value,
      'geographicAreaProvinceDestination', gapd.value,
      'consumerPriceProduct', cpip.value,
      'priceBaseDate', pbd.value,
      'weightPricePeriod', wpp.value,
      'weightGeographicDistribution', wgd.value,
      'flightSector', fs.value,
      'airFareTypeGroup', atg.value
    )) dimensions
  FROM observations o
  LEFT JOIN observation_dimension_geographicArea ga ON o.id = ga.observation_id
  LEFT JOIN observation_dimension_seasonallyAdjusted sa ON o.id = sa.observation_id
  LEFT JOIN observation_dimension_geographicArea_provinceDestination gapd ON o.id = gapd.observation_id
  LEFT JOIN observation_dimension_consumerPriceProduct cpip ON o.id = cpip.observation_id
  LEFT JOIN observation_dimension_priceBaseDate pbd ON o.id = pbd.observation_id
  LEFT JOIN observation_dimension_weightPricePeriod wpp ON o.id = wpp.observation_id
  LEFT JOIN observation_dimension_weightGeographicDistribution wgd ON o.id = wgd.observation_id
  LEFT JOIN observation_dimension_flightSector fs ON o.id = fs.observation_id
  LEFT JOIN observation_dimension_airFareTypeGroup atg ON o.id = atg.observation_id;

  ALTER VIEW "vObservationsDimensions" RENAME TO "vObservationsDimensions_old";
  CREATE VIEW "vObservationsDimensions" AS
  SELECT * FROM "mvObservationsDimensions";

  ALTER VIEW "vObservations" RENAME TO "vObservations_old";
  CREATE VIEW "vObservations" AS
  WITH last_value AS (
    SELECT
      id as value_id, observation_id, MAX(date) as dateModified
    FROM observation_values
    GROUP BY observation_id, id
  ),
  status AS (
    SELECT
      observation_value_id, ARRAY_AGG(s.name) as status
    FROM observation_status os
    INNER JOIN status s ON os.observation_status_id = s.id
    GROUP BY observation_value_id
  )
  SELECT
    o.id, i.name AS indicator, period, dimensions, value, status, dateModified as "dateModified"
  FROM observations o
  INNER JOIN last_value lv ON o.id = lv.observation_id
  INNER JOIN observation_values v ON v.id = lv.value_id
  INNER JOIN indicators i ON o.indicator_id = i.id
  INNER JOIN "vObservationsDimensions" d ON o.id = d.observation_id
  LEFT JOIN status s ON lv.value_id = s.observation_value_id;

  ALTER VIEW "vVectors" RENAME TO "vVectors_old";
  CREATE VIEW "vVectors" AS
  SELECT
    v.id, i.name AS indicator, dimensions
  FROM vectors v
  INNER JOIN indicators i ON v.indicator_id = i.id
  INNER JOIN "vObservations" od ON v.observation_id = od.id
  UNION
  SELECT vd.id, i.name AS indicator, dimensions::jsonb
  FROM vectors_duplicate vd
  INNER JOIN vectors v ON vd.vector_id = v.id
  INNER JOIN indicators i ON v.indicator_id = i.id
  INNER JOIN "vObservations" od ON v.observation_id = od.id
  ORDER BY id;

  DROP VIEW "vVectors_old";
  DROP VIEW "vObservations_old";
  DROP VIEW "vObservationsDimensions_old";
  DROP VIEW "vIndicators_old";
  DROP MATERIALIZED VIEW "mvObservationsDimensions_old";

  CREATE OR REPLACE FUNCTION add_observation (
    indicator_name varchar,
    observation_period varchar,
    value real,
    status_symbol varchar = NULL,
    observation_time timestamp = NOW()
  )
  RETURNS int
  AS $observation_id$
    DECLARE
      indicator_id_val integer;
      observation_id UUID;
      observation_value_id_val integer;
    BEGIN
      SELECT id INTO indicator_id_val FROM indicators WHERE name = indicator_name;

      INSERT INTO observations (id, indicator_id, period)
      VALUES(DEFAULT, indicator_id_val, TO_DATE(observation_period, 'YYYY-MM-DD'))
      RETURNING id INTO observation_id;

      INSERT INTO observation_values (observation_id, date, value)
      VALUES(observation_id, observation_time, value)
      RETURNING id INTO observation_value_id_val;

      IF NOT status_symbol = '' AND NOT status_symbol = NULL THEN
        INSERT INTO observation_status (observation_value_id, observation_status_id)
        VALUES(
          observation_value_id_val,
          (SELECT id FROM status WHERE symbol = status_symbol)
        );
      END IF;

      RETURN observation_id;
    END;
  $observation_id$ LANGUAGE plpgsql;

  CREATE OR REPLACE FUNCTION add_vector (
    vector_id int,
    observation_id_val integer
  )
  RETURNS int
  AS $vector_id$
    DECLARE
    BEGIN
      IF NOT EXISTS (SELECT * FROM vectors WHERE id = vector_id) THEN
        INSERT INTO vectors (id, indicator_id, observation_id)
        VALUES (vector_id, (
          SELECT indicator_id FROM observations WHERE id = observation_id_val
        ), observation_id_val);
      END IF;

      RETURN vector_id;
    END;
  $vector_id$ LANGUAGE plpgsql;

  FOREACH tbl IN ARRAY tables
  LOOP
    EXECUTE format('ALTER TABLE %s DROP CONSTRAINT IF EXISTS %s_observation_id_fkey', tbl, substr(tbl, 0, 44));
    EXECUTE format('ALTER TABLE %s DROP COLUMN observation_id_old', tbl);
  END LOOP;

  ALTER TABLE observations DROP CONSTRAINT observations_pkey;
  ALTER TABLE observations ADD PRIMARY KEY (id);
  ALTER TABLE observations DROP COLUMN id_old;

  FOREACH tbl IN ARRAY tables
  LOOP
    EXECUTE format('ALTER TABLE %s ADD CONSTRAINT %s_observation_id_fkey FOREIGN KEY (observation_id) REFERENCES observations (id) MATCH FULL;', tbl, substr(tbl, 0, 44));
  END LOOP;

  RETURN;
END; $$;
