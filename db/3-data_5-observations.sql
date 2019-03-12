DO $$
DECLARE
  indicator_id_val integer;
  observation_id_val integer;
BEGIN
  SELECT id INTO indicator_id_val FROM indicators WHERE name = 'population';

  INSERT INTO observations (id, indicator_id)
  VALUES(DEFAULT, indicator_id_val)
  RETURNING id INTO observation_id_val;

  INSERT INTO observation_dimension_period (observation_id, value)
  VALUES(observation_id_val, TO_DATE('2018-10-01', 'YYYY-MM-DD'));

  INSERT INTO observation_dimension_geographicArea (observation_id, value)
  VALUES(observation_id_val, '01');

  INSERT INTO observation_values (observation_id, date, value)
  VALUES(observation_id_val, NOW(), 37242571);

  /* ---- */

  INSERT INTO observations (id, indicator_id)
  VALUES(DEFAULT, indicator_id_val)
  RETURNING id INTO observation_id_val;

  INSERT INTO observation_dimension_period (observation_id, value)
  VALUES(observation_id_val, TO_DATE('2018-10-01', 'YYYY-MM-DD'));

  INSERT INTO observation_dimension_geographicArea (observation_id, value)
  VALUES(observation_id_val, '10');

  INSERT INTO observation_values (observation_id, date, value)
  VALUES(observation_id_val, NOW(), 525073);

  /* ---- */

  INSERT INTO observations (id, indicator_id)
  VALUES(DEFAULT, indicator_id_val)
  RETURNING id INTO observation_id_val;

  INSERT INTO observation_dimension_period (observation_id, value)
  VALUES(observation_id_val, TO_DATE('2018-10-01', 'YYYY-MM-DD'));

  INSERT INTO observation_dimension_geographicArea (observation_id, value)
  VALUES(observation_id_val, '11');

  INSERT INTO observation_values (observation_id, date, value)
  VALUES(observation_id_val, NOW(), 154750);
END; $$
