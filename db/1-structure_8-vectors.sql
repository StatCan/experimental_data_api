CREATE TABLE vectors (
  id integer PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  observation_id integer
);

CREATE TABLE vectors_duplicate (
  id integer PRIMARY KEY,
  vector_id integer REFERENCES vectors(id)
);
