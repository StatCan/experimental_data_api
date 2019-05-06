CREATE TABLE indicators (
  id serial PRIMARY KEY,
  name varchar NOT NULL,
  sdmx_id varchar,
  frequency_id integer REFERENCES frequencies(id),
  title hstore
);

CREATE TABLE indicator_dimensions (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  dimension_id integer REFERENCES dimensions(id)
);

CREATE TABLE indicator_subjects (
  id serial PRIMARY KEY,
  indicator_id integer REFERENCES indicators(id),
  subject_id integer REFERENCES subjects(id)
)
