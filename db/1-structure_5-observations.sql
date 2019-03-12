CREATE TABLE observations (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id)
);

CREATE TABLE observation_values (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  date timestamp,
  value decimal
);

CREATE TABLE observation_dimensions (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  dimensions hstore
);

CREATE OR REPLACE FUNCTION add_dimension() RETURNS TRIGGER AS $$
  DECLARE
  BEGIN
    IF ((SELECT COUNT(observation_id) FROM observation_dimensions WHERE observation_id = NEW.observation_id) = 0) THEN
      INSERT INTO observation_dimensions (observation_id, dimensions) VALUES(NEW.observation_id, '');
    END IF;

    UPDATE observation_dimensions
    SET dimensions = dimensions || hstore(TG_ARGV[0], CAST(NEW.value AS text))
    WHERE observation_id = NEW.observation_id;

    RETURN NEW;
  END; $$ LANGUAGE plpgsql;

CREATE TABLE observation_dimension_period (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value date
);

CREATE TRIGGER dimension_period_trigger AFTER INSERT ON observation_dimension_period
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("period");

CREATE TABLE observation_dimension_geographicArea (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value varchar(6)
);

CREATE TRIGGER dimension_geographicArea_trigger AFTER INSERT ON observation_dimension_geographicArea
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("geographicArea");

CREATE TYPE sex AS ENUM('male', 'female', 'all');

CREATE TABLE observation_dimension_sex (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value sex
);

CREATE TRIGGER dimension_sex_trigger AFTER INSERT ON observation_dimension_sex
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("sex");
