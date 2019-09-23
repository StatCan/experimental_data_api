ALTER VIEW "vVectors" RENAME TO "vVectors_old";
CREATE VIEW "vVectors" AS
SELECT
  v.id, v.timeseries_id timeseries
FROM vectors v
INNER JOIN timeseries t ON t.id = v.timeseries_id
ORDER BY id;

DROP VIEW "vVectors_old";
