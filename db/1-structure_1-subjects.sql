CREATE EXTENSION hstore;

CREATE TABLE subjects (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  title hstore
);
