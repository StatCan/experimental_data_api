CREATE FUNCTION add_observation (
  indicator_name varchar,
  observation_period varchar,
  value real,
  status_symbol varchar = NULL,
  observation_time timestamp = NOW()
)
RETURNS int
AS $observation_id$
  DECLARE
    indicator_id_val integer;
    observation_id integer;
    observation_value_id_val integer;
  BEGIN
    SELECT id INTO indicator_id_val FROM indicators WHERE name = indicator_name;

    INSERT INTO observations (id, indicator_id, period)
    VALUES(DEFAULT, indicator_id_val, TO_DATE(observation_period, 'YYYY-MM-DD'))
    RETURNING id INTO observation_id;

    INSERT INTO observation_values (observation_id, date, value)
    VALUES(observation_id, observation_time, value)
    RETURNING id INTO observation_value_id_val;

    IF NOT status_symbol = '' AND NOT status_symbol = NULL THEN
      INSERT INTO observation_status (observation_value_id, observation_status_id)
      VALUES(
        observation_value_id_val,
        (SELECT id FROM status WHERE symbol = status_symbol)
      );
    END IF;

    RETURN observation_id;
  END;
$observation_id$ LANGUAGE plpgsql;
