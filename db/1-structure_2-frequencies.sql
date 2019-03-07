CREATE TABLE frequencies (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  sdmx_id char(1),
  title hstore
);
