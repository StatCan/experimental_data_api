CREATE VIEW "vVectors" AS
SELECT
  v.id, i.name AS indicator, dimensions::jsonb
FROM vectors v
INNER JOIN indicators i ON v.indicator_id = i.id;
