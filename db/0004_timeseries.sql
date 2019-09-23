DO $$
DECLARE
  dimensions varchar[] := array[
    'geographicArea',
    'seasonallyAdjusted',
    'geographicArea_provinceDestination',
    'consumerPriceProduct',
    'priceBaseDate',
    'weightPricePeriod',
    'weightGeographicDistribution',
    'sex',
    'flightSector',
    'airFareTypeGroup'
  ];
  dm varchar;
BEGIN
  CREATE TABLE timeseries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    indicator_id integer REFERENCES indicators(id),
    observation_id UUID REFERENCES observations(id)
  );

  ALTER TABLE observations
  ADD COLUMN timeseries_id UUID REFERENCES timeseries(id);

  ALTER TABLE vectors
  ADD COLUMN timeseries_id UUID REFERENCES timeseries(id);

  INSERT INTO timeseries(indicator_id, observation_id)
  SELECT indicator_id, observation_id FROM vectors;

  UPDATE vectors
  SET timeseries_id = timeseries.id
  FROM timeseries
  WHERE vectors.observation_id = timeseries.observation_id;

  UPDATE observations
  SET timeseries_id = s.timeseries_id
  FROM (
    select o.id, v.indicator, v.dimensions, timeseries_id
    from "vVectors" v
    inner join vectors ON v.id = vectors.id
    inner join "vObservations" o on v.indicator = o.indicator AND v.dimensions = o.dimensions
  ) s
  WHERE observations.id = s.id;

  FOREACH dm IN ARRAY dimensions
  LOOP
    EXECUTE format('ALTER TABLE observation_dimension_%s RENAME TO timeseries_dimension_%s', dm, dm);
    EXECUTE format('ALTER TABLE timeseries_dimension_%s ADD COLUMN timeseries_id UUID REFERENCES timeseries(id)', dm);
    EXECUTE format('DELETE FROM timeseries_dimension_%s WHERE observation_id NOT IN (SELECT observation_id FROM vectors)', dm);
    EXECUTE format('UPDATE timeseries_dimension_%s d SET timeseries_id = v.timeseries_id FROM vectors v WHERE v.observation_id = d.observation_id', dm);
  END LOOP;

  ALTER VIEW "vIndicators" RENAME TO "vIndicators_old";
  CREATE VIEW "vIndicators" AS
    WITH last_modified AS (
      SELECT
        t.indicator_id, MAX(date) AS dateModified
      FROM observations o
      INNER JOIN timeseries t ON t.id = o.timeseries_id
      INNER JOIN observation_values v ON o.id = v.observation_id
      GROUP BY t.indicator_id
    ), dimensions AS (
      SELECT
        indicator_id, ARRAY_AGG(d.name) as dimensions
      FROM dimensions d
      INNER JOIN indicator_dimensions id ON d.id = id.dimension_id
      GROUP BY indicator_id
    ), period AS (
      SELECT
        t.indicator_id, MIN(period) AS min, MAX(period) AS max
      FROM observations o
      INNER JOIN timeseries t ON t.id = o.timeseries_id
      GROUP BY t.indicator_id
    )
    SELECT
      i.name as id, i.sdmx_id AS "sdmxId", i.title::jsonb, f.name AS frequency, (p.min || '/' || p.max) AS "temporalCoverage", dimensions, m.dateModified AS "dateModified"
    FROM indicators i
    INNER JOIN frequencies f ON i.frequency_id = f.id
    INNER JOIN dimensions d ON i.id = d.indicator_id
    LEFT JOIN last_modified m ON i.id = m.indicator_id
    LEFT JOIN period p ON i.id = p.indicator_id;

  CREATE MATERIALIZED VIEW "mvTimeseriesDimensions" AS
  SELECT
    t.id timeseries_id,
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
  FROM timeseries t
  LEFT JOIN timeseries_dimension_geographicArea ga ON t.id = ga.timeseries_id
  LEFT JOIN timeseries_dimension_seasonallyAdjusted sa ON t.id = sa.timeseries_id
  LEFT JOIN timeseries_dimension_geographicArea_provinceDestination gapd ON t.id = gapd.timeseries_id
  LEFT JOIN timeseries_dimension_consumerPriceProduct cpip ON t.id = cpip.timeseries_id
  LEFT JOIN timeseries_dimension_priceBaseDate pbd ON t.id = pbd.timeseries_id
  LEFT JOIN timeseries_dimension_weightPricePeriod wpp ON t.id = wpp.timeseries_id
  LEFT JOIN timeseries_dimension_weightGeographicDistribution wgd ON t.id = wgd.timeseries_id
  LEFT JOIN timeseries_dimension_flightSector fs ON t.id = fs.timeseries_id
  LEFT JOIN timeseries_dimension_airFareTypeGroup atg ON t.id = atg.timeseries_id;

  CREATE VIEW "vTimeseriesDimensions" AS
  SELECT * FROM "mvTimeseriesDimensions";

  ALTER VIEW "vObservations" RENAME TO "vObservations_old";
  CREATE OR REPLACE VIEW "vObservations" AS
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
    o.id, i.name AS indicator, t.id timeseries, period, dimensions, value, status, dateModified as "dateModified"
  FROM observations o
  INNER JOIN last_value lv ON o.id = lv.observation_id
  INNER JOIN observation_values v ON v.id = lv.value_id
  INNER JOIN "vTimeseriesDimensions" d ON o.timeseries_id = d.timeseries_id
  INNER JOIN timeseries t ON t.id = d.timeseries_id
  INNER JOIN indicators i ON i.id = t.indicator_id
  LEFT JOIN status s ON lv.value_id = s.observation_value_id;

  ALTER VIEW "vVectors" RENAME TO "vVectors_old";
  CREATE VIEW "vVectors" AS
  SELECT
    v.id, v.timeseries_id timeserie, i.name AS indicator, dimensions
  FROM vectors v
  INNER JOIN timeseries t ON t.id = v.timeseries_id
  INNER JOIN "vTimeseriesDimensions" tv ON t.id = tv.timeseries_id
  INNER JOIN indicators i ON i.id = t.indicator_id
  ORDER BY id;

  DROP VIEW "vIndicators_old";
  DROP VIEW "vVectors_old";
  DROP VIEW "vObservations_old";
  DROP VIEW "vObservationsDimensions";
  DROP MATERIALIZED VIEW "mvObservationsDimensions";

  DROP FUNCTION add_observation;
  DROP FUNCTION add_vector;

  FOREACH dm IN ARRAY dimensions
  LOOP
    EXECUTE format('ALTER TABLE timeseries_dimension_%s DROP COLUMN observation_id', dm);
  END LOOP;

  ALTER TABLE observations DROP COLUMN indicator_id;
  ALTER TABLE vectors DROP COLUMN observation_id;
  ALTER TABLE timeseries DROP COLUMN observation_id;
END; $$;
