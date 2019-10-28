ALTER MATERIALIZED VIEW "mvTimeseriesDimensions" RENAME TO "mvTimeseriesDimensions_old";
CREATE MATERIALIZED VIEW "mvTimeseriesDimensions" AS
SELECT
  t.id timeseries_id,
  jsonb_strip_nulls(jsonb_build_object(
    'geographicArea', ga.value,
    'seasonallyAdjusted', sa.value,
    'sex', sex.value,
    'geographicAreaProvinceDestination', gapd.value,
    'consumerPriceProduct', cpip.value,
    'priceBaseDate', pbd.value,
    'weightPricePeriod', wpp.value,
    'weightGeographicDistribution', wgd.value,
    'flightSector', fs.value,
    'airFareTypeGroup', atg.value
  )) dimensions
FROM timeseries t
LEFT JOIN "vDimensiongeographicArea" ga ON t.id = ga.timeseries_id
LEFT JOIN timeseries_dimension_seasonallyAdjusted sa ON t.id = sa.timeseries_id
LEFT JOIN "vDimensionsex" sex ON t.id = sex.timeseries_id
LEFT JOIN "vDimensiongeographicArea_provinceDestination" gapd ON t.id = gapd.timeseries_id
LEFT JOIN "vDimensionconsumerPriceProduct" cpip ON t.id = cpip.timeseries_id
LEFT JOIN timeseries_dimension_priceBaseDate pbd ON t.id = pbd.timeseries_id
LEFT JOIN "vDimensionweightPricePeriod" wpp ON t.id = wpp.timeseries_id
LEFT JOIN "vDimensionweightGeographicDistribution" wgd ON t.id = wgd.timeseries_id
LEFT JOIN "vDimensionflightSector" fs ON t.id = fs.timeseries_id
LEFT JOIN "vDimensionairFareTypeGroup" atg ON t.id = atg.timeseries_id;

CREATE OR REPLACE VIEW "vTimeseriesDimensions" AS
SELECT * FROM "mvTimeseriesDimensions";

DROP MATERIALIZED VIEW "mvTimeseriesDimensions_old";
