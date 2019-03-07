CREATE TABLE dimensions (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  title hstore
);
