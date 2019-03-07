CREATE TABLE observations (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id)
);

CREATE TABLE observation_dimensions (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  period date,
  geographicArea varchar(6)
);

CREATE TABLE observation_values (
  id serial PRIMARY KEY,
  observation_id integer REFERENCES observations(id),
  date timestamp,
  value decimal
);
