CREATE VIEW "vIndicators" AS
  WITH last_modified AS (
    SELECT indicator_id, MAX(date) AS dateModified
    FROM observations o
    INNER JOIN observation_values v ON o.id = v.observation_id
    GROUP BY indicator_id
  ), dimensions AS (
    SELECT indicator_id, ARRAY_AGG(d.name) as dimensions
    FROM indicator_dimensions id
    INNER JOIN dimensions d ON id.dimension_id = d.id
    GROUP BY indicator_id
  )
  SELECT
    i.name as id, i.sdmx_id AS "sdmxId", i.title::jsonb, f.name AS frequency, dimensions, m.dateModified
  FROM indicators i
  INNER JOIN frequencies f ON i.frequency_id = f.id
  INNER JOIN dimensions d ON d.indicator_id = i.id
  LEFT JOIN last_modified m ON i.id = m.indicator_id;
