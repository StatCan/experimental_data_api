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
  INNER JOIN observation_dimensions d ON o.id = d.observation_id
  LEFT JOIN status s ON lv.value_id = s.observation_value_id;
