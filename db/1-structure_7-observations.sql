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

CREATE TABLE observation_dimension_geographicArea (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value varchar(7)
);

CREATE TABLE observation_dimension_seasonallyAdjusted (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value boolean
);

CREATE TABLE observation_dimension_geographicArea_provinceDestination (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value varchar(7)
);

CREATE TABLE observation_dimension_consumerPriceProduct(
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value cpiProduct
);

CREATE TABLE observation_dimension_priceBaseDate(
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value date
);

CREATE TABLE observation_dimension_weightPricePeriod(
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value cpiWeightPricePeriod
);

CREATE TABLE observation_dimension_weightGeographicDistribution(
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value cpiWeightGeographicDistribution
);

CREATE TABLE observation_dimension_sex (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value sex
);

CREATE TABLE observation_dimension_flightSector (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value flightSector
);

CREATE TABLE observation_dimension_airFareTypeGroup(
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  value airFareTypeGroup
);
