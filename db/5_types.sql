CREATE TABLE type_geographicArea (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_geographicArea ADD COLUMN value_id INTEGER REFERENCES type_geographicArea(id);
ALTER TABLE timeseries_dimension_geographicArea_provinceDestination ADD COLUMN value_id INTEGER REFERENCES type_geographicArea(id);

CREATE TABLE type_sex (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_sex ADD COLUMN value_id INTEGER REFERENCES type_sex(id);

CREATE TABLE type_flightSector (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_flightSector  ADD COLUMN value_id INTEGER REFERENCES type_flightSector(id);

CREATE TABLE type_airFareTypeGroup (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_airFareTypeGroup ADD COLUMN value_id INTEGER REFERENCES type_airFareTypeGroup(id);

CREATE TABLE type_consumerPriceProduct (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_consumerPriceProduct ADD COLUMN value_id INTEGER REFERENCES type_consumerPriceProduct(id);

CREATE TABLE type_weightPricePeriod (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_weightPricePeriod ADD COLUMN value_id INTEGER REFERENCES type_weightPricePeriod(id);

CREATE TABLE type_weightGeographicDistribution (
  id serial PRIMARY KEY,
  name varchar
);
ALTER TABLE timeseries_dimension_weightGeographicDistribution ADD COLUMN value_id INTEGER REFERENCES type_weightGeographicDistribution(id);
