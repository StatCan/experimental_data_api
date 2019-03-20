CREATE VIEW "vObservations" AS
  WITH last_value AS (
    SELECT
      id as value_id, observation_id, MAX(date) as dateModified
    FROM observation_values v
    GROUP BY observation_id, id
  )
  SELECT
    o.id, i.name AS indicator, period, dimensions::jsonb, value, dateModified as "dateModified"
  FROM observations o
  INNER JOIN last_value lv ON o.id = lv.observation_id
  INNER JOIN observation_values v ON v.id = lv.value_id
  INNER JOIN indicators i ON o.indicator_id = i.id
  INNER JOIN observation_dimensions d ON o.id = d.observation_id;
