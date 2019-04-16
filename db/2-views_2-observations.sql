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
  ),
  observation_dimensions AS (
    SELECT
      o.id observation_id,
      jsonb_strip_nulls(jsonb_build_object(
        'geographicArea', ga.value,
        'seasonallyAdjusted', sa.value,
        'consumerPriceProduct', cpip.observation_id,
        'priceBaseDate', pbd.observation_id,
        'weightPricePeriod', wpp.observation_id,
        'weightGeographicDistribution', wgd.observation_id,
        'flightSector', fs.value,
        'airFareTypeGroup', atg.value
      )) dimensions
    FROM observations o
    LEFT JOIN observation_dimension_geographicArea ga ON o.id = ga.observation_id
    LEFT JOIN observation_dimension_seasonallyAdjusted sa ON o.id = sa.observation_id
    LEFT JOIN observation_dimension_consumerPriceProduct cpip ON o.id = cpip.observation_id
    LEFT JOIN observation_dimension_priceBaseDate pbd ON o.id = pbd.observation_id
    LEFT JOIN observation_dimension_weightPricePeriod wpp ON o.id = wpp.observation_id
    LEFT JOIN observation_dimension_weightGeographicDistribution wgd ON o.id = wgd.observation_id
    LEFT JOIN observation_dimension_flightSector fs ON o.id = fs.observation_id
    LEFT JOIN observation_dimension_airFareTypeGroup atg ON o.id = atg.observation_id
  )
  SELECT
    o.id, i.name AS indicator, period, dimensions, value, status, dateModified as "dateModified"
  FROM observations o
  INNER JOIN last_value lv ON o.id = lv.observation_id
  INNER JOIN observation_values v ON v.id = lv.value_id
  INNER JOIN indicators i ON o.indicator_id = i.id
  INNER JOIN observation_dimensions d ON o.id = d.observation_id
  LEFT JOIN status s ON lv.value_id = s.observation_value_id;
