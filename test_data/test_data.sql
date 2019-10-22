INSERT INTO subjects (name, title)
VALUES
(
  'subject_1',
  hstore(ARRAY[['en', 'Subject 1'], ['fr', 'Subject 1']])
),
(
  'subject_2',
  hstore(ARRAY[['en', 'Subject 2'], ['fr', 'Subject 2']])
);

INSERT INTO frequencies (name, sdmx_id, title)
VALUES
(
  'quarterly', 'Q',
  hstore(ARRAY[['en', 'Quarterly'], ['fr', 'Trimestriel']])
),
(
  'monthly', 'M',
  hstore(ARRAY[['en', 'Monthly'], ['fr', 'Mensuel']])
);


INSERT INTO status (name, symbol)
VALUES
('not_available', '.');

INSERT INTO dimensions (name, title)
VALUES
(
  'geographicArea',
  hstore(ARRAY[['en', ''], ['fr', '']])
),
(
  'sex',
  hstore(ARRAY[['en', ''], ['fr', '']])
);

INSERT INTO type_geographicArea (name)
VALUES
('24'),
('35');


INSERT INTO type_sex (name)
VALUES
('male'),
('female');

INSERT INTO indicators (name, frequency_id, title)
VALUES
(
  'indicator1', (SELECT id FROM frequencies WHERE name = 'quarterly'),
  hstore(ARRAY[['en', 'Indicator 1'], ['fr', 'Indicateur 1']])
);

INSERT INTO indicators (name, frequency_id, title)
VALUES
(
  'indicator2', (SELECT id FROM frequencies WHERE name = 'monthly'),
  hstore(ARRAY[['en', 'Indicator 2'], ['fr', 'Indicateur 2']])
);

INSERT INTO indicator_subjects (indicator_id, subject_id)
VALUES (
  (SELECT id FROM indicators WHERE name = 'indicator1'),
  (SELECT id FROM subjects WHERE name = 'subject1')
);

INSERT INTO indicator_subjects (indicator_id, subject_id)
VALUES (
  (SELECT id FROM indicators WHERE name = 'indicator2'),
  (SELECT id FROM subjects WHERE name = 'subject2')
);

INSERT INTO indicator_dimensions (indicator_id, dimension_id)
VALUES (
  (SELECT id FROM indicators WHERE name = 'indicator1'),
  (SELECT id FROM dimensions WHERE name = 'geographicArea')
);

INSERT INTO indicator_dimensions (indicator_id, dimension_id)
VALUES
(
  (SELECT id FROM indicators WHERE name = 'indicator2'),
  (SELECT id FROM dimensions WHERE name = 'geographicArea')
),
(
  (SELECT id FROM indicators WHERE name = 'indicator2'),
  (SELECT id FROM dimensions WHERE name = 'sex')
);

INSERT INTO timeseries
VALUES ('d3a06c6b-82a7-4efa-8f0f-6cb453deff2c', (SELECT id FROM indicators WHERE name = 'indicator1'));

INSERT INTO timeseries
VALUES ('3d9e3917-8a39-4eb6-917c-bf485dd0b20b', (SELECT id FROM indicators WHERE name = 'indicator1'));

INSERT INTO timeseries
VALUES ('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', (SELECT id FROM indicators WHERE name = 'indicator2'));

INSERT INTO timeseries
VALUES ('e6c20549-b6a6-4107-8bfe-6f67f962d65a', (SELECT id FROM indicators WHERE name = 'indicator2'));

INSERT INTO timeseries
VALUES ('699b644d-dd26-430d-9f56-b4fc6760569c', (SELECT id FROM indicators WHERE name = 'indicator2'));

INSERT INTO timeseries
VALUES ('ac139d12-22ce-45ba-a63e-14f1dc9f3ec4', (SELECT id FROM indicators WHERE name = 'indicator2'));

INSERT INTO vectors
VALUES (1, 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c');

INSERT INTO vectors
VALUES (2, '3d9e3917-8a39-4eb6-917c-bf485dd0b20b');

INSERT INTO vectors
VALUES (3, 'e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5');

INSERT INTO vectors
VALUES (4, 'e6c20549-b6a6-4107-8bfe-6f67f962d65a');

INSERT INTO vectors
VALUES (5, '699b644d-dd26-430d-9f56-b4fc6760569c');

INSERT INTO vectors
VALUES (6, 'ac139d12-22ce-45ba-a63e-14f1dc9f3ec4');

INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
VALUES ('d3a06c6b-82a7-4efa-8f0f-6cb453deff2c', (SELECT id FROM type_geographicArea WHERE name = '24'));

INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
VALUES ('3d9e3917-8a39-4eb6-917c-bf485dd0b20b', (SELECT id FROM type_geographicArea WHERE name = '35'));

INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
VALUES ('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', (SELECT id FROM type_geographicArea WHERE name = '24'));

INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
VALUES ('e6c20549-b6a6-4107-8bfe-6f67f962d65a', (SELECT id FROM type_geographicArea WHERE name = '35'));

INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
VALUES ('699b644d-dd26-430d-9f56-b4fc6760569c', (SELECT id FROM type_geographicArea WHERE name = '24'));

INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
VALUES ('ac139d12-22ce-45ba-a63e-14f1dc9f3ec4', (SELECT id FROM type_geographicArea WHERE name = '35'));

INSERT INTO timeseries_dimension_sex (timeseries_id, value_id)
VALUES ('e052c4b3-ae8b-43ca-a6f7-ff75fcfc49c5', (SELECT id FROM type_sex WHERE name = 'male'));

INSERT INTO timeseries_dimension_sex (timeseries_id, value_id)
VALUES ('e6c20549-b6a6-4107-8bfe-6f67f962d65a', (SELECT id FROM type_sex WHERE name = 'female'));

INSERT INTO timeseries_dimension_sex (timeseries_id, value_id)
VALUES ('699b644d-dd26-430d-9f56-b4fc6760569c', (SELECT id FROM type_sex WHERE name = 'male'));

INSERT INTO timeseries_dimension_sex (timeseries_id, value_id)
VALUES ('ac139d12-22ce-45ba-a63e-14f1dc9f3ec4', (SELECT id FROM type_sex WHERE name = 'female'));

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-01-01', 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c')
  RETURNING id
)
INSERT INTO observation_values (observation_id, value)
SELECT id, 29 FROM o;

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-02-01', 'd3a06c6b-82a7-4efa-8f0f-6cb453deff2c')
  RETURNING id
)
INSERT INTO observation_values (observation_id, value)
SELECT id, 35 FROM o;

---

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-01-01', '3d9e3917-8a39-4eb6-917c-bf485dd0b20b')
  RETURNING id
)
INSERT INTO observation_values (observation_id, value)
SELECT id, 2.5 FROM o;

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-02-01', '3d9e3917-8a39-4eb6-917c-bf485dd0b20b')
  RETURNING id
)
INSERT INTO observation_values (observation_id, value)
SELECT id, 2.9 FROM o;

---

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-01-01', '3d9e3917-8a39-4eb6-917c-bf485dd0b20b')
  RETURNING id
)
INSERT INTO observation_values (observation_id, value)
SELECT id, 29 FROM o;

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-02-01', '3d9e3917-8a39-4eb6-917c-bf485dd0b20b')
  RETURNING id
)
INSERT INTO observation_values (observation_id, value)
SELECT id, 35 FROM o;

WITH o AS (
  INSERT INTO observations (period, timeseries_id)
  VALUES ('2019-03-01', '3d9e3917-8a39-4eb6-917c-bf485dd0b20b')
  RETURNING id
), v AS (
  INSERT INTO observation_values (observation_id)
  SELECT id FROM o
  RETURNING id
)
INSERT INTO observation_status (observation_value_id, observation_status_id)
SELECT id, (SELECT id FROM status WHERE name = 'not_available') FROM v;

---

REFRESH MATERIALIZED VIEW "mvTimeseriesDimensions";
