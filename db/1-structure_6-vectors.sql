CREATE TABLE vectors (
  id integer PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  dimensions hstore
);
