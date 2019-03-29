CREATE VIEW "vVectors" AS
SELECT
  v.id, i.name AS indicator, dimensions::jsonb
FROM vectors v
INNER JOIN indicators i ON v.indicator_id = i.id
UNION
SELECT vd.id, i.name AS indicator, dimensions::jsonb
FROM vectors_duplicate vd
INNER JOIN vectors v ON vd.vector_id = v.id
INNER JOIN indicators i ON v.indicator_id = i.id
ORDER BY id;
