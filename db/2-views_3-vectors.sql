CREATE VIEW "vVectors" AS
SELECT
  v.id, i.name AS indicator, dimensions
FROM vectors v
INNER JOIN indicators i ON v.indicator_id = i.id
INNER JOIN observation_dimensions od ON v.observation_id = od.observation_id
UNION
SELECT vd.id, i.name AS indicator, dimensions::jsonb
FROM vectors_duplicate vd
INNER JOIN vectors v ON vd.vector_id = v.id
INNER JOIN indicators i ON v.indicator_id = i.id
INNER JOIN observation_dimensions od ON v.observation_id = od.observation_id
ORDER BY id;
