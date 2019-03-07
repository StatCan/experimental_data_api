DO $$
DECLARE
  indicator_id_val integer;
  observation_id_val integer;
BEGIN
  SELECT id INTO indicator_id_val FROM indicators WHERE name = 'death';

  INSERT INTO observations (id, indicator_id)
  VALUES(DEFAULT, indicator_id_val)
  RETURNING id INTO observation_id_val;

  INSERT INTO observation_values (observation_id, date, value)
  VALUES(observation_id_val, NOW(), 37242571);
END; $$
