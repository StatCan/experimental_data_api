CREATE ROLE readaccess;

GRANT USAGE ON SCHEMA public TO readaccess;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readaccess;

DO $$
DECLARE
   password varchar := (SELECT current_setting('custom.readonly_pwd'));
BEGIN
  EXECUTE format('CREATE USER %I PASSWORD %L', 'api', password);
END $$;

GRANT readaccess TO api;

CREATE EXTENSION hstore;

/* -- Indicators -- */

CREATE TABLE subjects (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  title hstore
);

CREATE TABLE frequencies (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  sdmx_id char(1),
  title hstore
);

CREATE TABLE dimensions (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  title hstore
);

CREATE TABLE indicators (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  sdmx_id varchar,
  frequency_id integer REFERENCES frequencies(id),
  title hstore
);

CREATE TABLE indicator_dimensions (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  dimension_id integer REFERENCES dimensions(id)
);

CREATE TABLE indicator_subjects (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  subject_id integer REFERENCES subjects(id)
);

/* -- Observations -- */

CREATE TABLE status (
  id serial PRIMARY KEY,
  name varchar,
  symbol varchar
);

CREATE TABLE observations (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  period date
);

CREATE TABLE observation_values (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  date timestamp,
  value real
);

CREATE TABLE observation_status (
  id serial PRIMARY KEY,
  observation_value_id integer REFERENCES observation_values(id),
  observation_status_id integer REFERENCES status(id)
);

/* -- Vectors -- */

CREATE TABLE vectors (
  id integer PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  observation_id integer
);

CREATE TABLE vectors_duplicate (
  id integer PRIMARY KEY,
  vector_id integer REFERENCES vectors(id)
);

/* -- Views -- */

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

CREATE MATERIALIZED VIEW "mvObservationsDimensions" AS
SELECT
  o.id observation_id,
  jsonb_strip_nulls(jsonb_build_object()) dimensions
FROM observations o;

CREATE VIEW "vObservationsDimensions" AS
SELECT * FROM "mvObservationsDimensions";

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
INNER JOIN "vObservationsDimensions" d ON o.id = d.observation_id
LEFT JOIN status s ON lv.value_id = s.observation_value_id;

CREATE VIEW "vVectors" AS
SELECT
  v.id, i.name AS indicator, dimensions
FROM vectors v
INNER JOIN indicators i ON v.indicator_id = i.id
INNER JOIN "vObservations" od ON v.observation_id = od.id
UNION
SELECT vd.id, i.name AS indicator, dimensions::jsonb
FROM vectors_duplicate vd
INNER JOIN vectors v ON vd.vector_id = v.id
INNER JOIN indicators i ON v.indicator_id = i.id
INNER JOIN "vObservations" od ON v.observation_id = od.id
ORDER BY id;

/* -- Functions -- */

CREATE FUNCTION add_observation (
  indicator_name varchar,
  observation_period varchar,
  value real,
  status_symbol varchar = NULL,
  observation_time timestamp = NOW()
)
RETURNS int
AS $observation_id$
  DECLARE
    indicator_id_val integer;
    observation_id integer;
    observation_value_id_val integer;
  BEGIN
    SELECT id INTO indicator_id_val FROM indicators WHERE name = indicator_name;

    INSERT INTO observations (id, indicator_id, period)
    VALUES(DEFAULT, indicator_id_val, TO_DATE(observation_period, 'YYYY-MM-DD'))
    RETURNING id INTO observation_id;

    INSERT INTO observation_values (observation_id, date, value)
    VALUES(observation_id, observation_time, value)
    RETURNING id INTO observation_value_id_val;

    IF NOT status_symbol = '' AND NOT status_symbol = NULL THEN
      INSERT INTO observation_status (observation_value_id, observation_status_id)
      VALUES(
        observation_value_id_val,
        (SELECT id FROM status WHERE symbol = status_symbol)
      );
    END IF;

    RETURN observation_id;
  END;
$observation_id$ LANGUAGE plpgsql;

CREATE FUNCTION add_vector (
  vector_id int,
  observation_id_val integer
)
RETURNS int
AS $vector_id$
  DECLARE
  BEGIN
    IF NOT EXISTS (SELECT * FROM vectors WHERE id = vector_id) THEN
      INSERT INTO vectors (id, indicator_id, observation_id)
      VALUES (vector_id, (
        SELECT indicator_id FROM observations WHERE id = observation_id_val
      ), observation_id_val);
    END IF;

    RETURN vector_id;
  END;
$vector_id$ LANGUAGE plpgsql;
