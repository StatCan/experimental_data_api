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
