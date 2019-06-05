CREATE MATERIALIZED VIEW "vObservationsDimensions" AS
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
  LEFT JOIN observation_dimension_airFareTypeGroup atg ON o.id = atg.observation_id
