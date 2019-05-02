CREATE FUNCTION add_vector (
  vector_id int,
  observation_id_val integer
)
RETURNS int
AS $vector_id$
  DECLARE
  BEGIN
    IF NOT EXISTS (SELECT * FROM vectors WHERE id = vector_id) THEN
      INSERT INTO vectors (id, indicator_id, observation_id)
      VALUES (vector_id, (
        SELECT indicator_id FROM observations WHERE id = observation_id_val
      ), observation_id_val);
    END IF;

    RETURN vector_id;
  END;
$vector_id$ LANGUAGE plpgsql;
