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

CREATE TABLE observation_dimension_geographicArea (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value varchar(7)
);

CREATE TRIGGER dimension_geographicArea_trigger AFTER INSERT ON observation_dimension_geographicArea
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("geographicArea");

CREATE TABLE observation_dimension_geographicArea_provinceDestination (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value varchar(7)
);

CREATE TRIGGER dimension_geographicArea_provinceDestination_trigger AFTER INSERT ON observation_dimension_geographicArea_provinceDestination
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("geographicArea_provinceDestination");

CREATE TYPE sex AS ENUM('male', 'female', 'all');

CREATE TABLE observation_dimension_sex (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value sex
);

CREATE TRIGGER dimension_sex_trigger AFTER INSERT ON observation_dimension_sex
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("sex");

CREATE TYPE flightSector AS ENUM('domestic_and_international', 'domestic', 'international', 'shortHaul', 'longHaul');

CREATE TABLE observation_dimension_flightSector (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value flightSector
);

CREATE TRIGGER dimension_flightSector_trigger AFTER INSERT ON observation_dimension_flightSector
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("flightSector");

CREATE TYPE airFareTypeGroup AS ENUM('all', 'business', 'economy', 'discounted', 'other');

CREATE TABLE observation_dimension_airFareTypeGroup(
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value airFareTypeGroup
);

CREATE TRIGGER dimension_airFareTypeGroup_trigger AFTER INSERT ON observation_dimension_airFareTypeGroup
  FOR EACH ROW EXECUTE PROCEDURE add_dimension("airFareTypeGroup");
