CREATE VIEW "vTimeseries" AS
SELECT
  t.id, i.name AS indicator, dimensions
FROM timeseries t
INNER JOIN indicators i ON t.indicator_id = i.id
INNER JOIN "vTimeseriesDimensions" d ON d.timeseries_id = t.id;
