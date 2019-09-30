DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'population', 'DEM_POP', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Population Estimates'], ['fr', '']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := '60dca461-8a9d-4175-88b6-3c349573eb20';
    vector integer := 1;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := '59f83081-1507-4f8a-b995-d5a4332a7c72';
      vector integer := 2;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '35d938a9-fff0-4a22-a70d-ad5c2f0de72c';
      vector integer := 8;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '5ca6ef1c-43cc-4eea-9c7e-9b2207b45607';
      vector integer := 9;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '02253e43-c1c1-4ec6-a675-90e33445f10d';
      vector integer := 10;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'ac91ad17-dea5-4b05-aad3-3637f592c691';
      vector integer := 11;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '1497b22a-5f79-4d22-be25-71062038a95e';
      vector integer := 12;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'bff63271-2c42-47d3-a139-a4d782447e02';
      vector integer := 13;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'ce32b956-6739-4547-b9a9-07738bebbfa0';
      vector integer := 14;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '856d794c-cb7a-4706-b3ce-49d81606a87f';
      vector integer := 15;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '16c659d8-e356-4a56-9918-832ee227dc82';
      vector integer := 3;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'f98cb5b1-c8fb-4c30-9ff5-ab0b3044793c';
      vector integer := 4;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'c846ce60-3c9b-4bac-b20e-916ef7ee0971';
      vector integer := 6;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'e59de57e-b94c-4548-be60-2ec3668393fb';
      vector integer := 7;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'births', 'DEM_LVB', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Births'], ['fr', 'Naissances']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := 'b0ebf056-7d2f-49b9-a8ba-8d295a6ce3bc';
    vector integer := 62;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := '8f90e862-78fe-4275-a314-5e2ceac3365f';
      vector integer := 63;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'faf956a8-5126-4018-ad36-184a9f671998';
      vector integer := 69;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a1d15d8d-78e4-447c-aed1-ed473daca207';
      vector integer := 70;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '73051aa8-009b-45e2-826d-7fdb8abbcd0b';
      vector integer := 71;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '1e3266e7-0c12-4d27-b280-9e614c3b4d21';
      vector integer := 72;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '547f1677-e748-4bc0-a745-6ea5cb7fe38b';
      vector integer := 73;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'cdbf7a38-67d5-4e44-80df-b6d579763a9d';
      vector integer := 74;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'f739887d-d62d-492a-ba75-9199710cb433';
      vector integer := 75;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a2a918c6-f64a-45e3-abc0-08c0271bd237';
      vector integer := 76;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'e3932c14-cf80-4fcb-a344-095a0bdb2383';
      vector integer := 64;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '0d9071e7-d3c1-4226-948d-5f002e8dbd65';
      vector integer := 65;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'd6bf3cb2-2559-454f-b93c-7037066cd1c3';
      vector integer := 67;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '81a46a10-2934-49c6-8f6c-a010010bc6c3';
      vector integer := 68;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'deaths', 'DEM_DTH', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Deaths'], ['fr', 'Décès']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := '37e98a50-468f-445e-9dd4-07bbabe9a4fd';
    vector integer := 77;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := 'cb57dc40-187d-4933-b10a-c44cbcf6f964';
      vector integer := 78;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '45048aa8-3c5e-4ac1-b6f9-8fbc545e8bf9';
      vector integer := 84;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a5cbef01-d72b-4a69-938b-8a34040bf1bb';
      vector integer := 85;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'cc7fc6a8-3728-4fa7-863d-a49282a8a8bd';
      vector integer := 86;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '6cc9832a-114e-45c4-af0d-4afb5e5479bf';
      vector integer := 87;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'fc78f661-1e66-44c8-ab45-8659ad2cf15a';
      vector integer := 88;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '412a2bd1-63cb-493a-a66c-96897451f41b';
      vector integer := 89;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'c67e2d47-642d-49ea-9a36-26a56b2dd653';
      vector integer := 90;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '16b554e3-cb02-4ae0-ad40-3a6114048480';
      vector integer := 91;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '28b01382-baeb-431e-a13a-4044e8ec0d34';
      vector integer := 79;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '7b53aed3-7a67-4c11-899f-362314296833';
      vector integer := 80;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'd2d21781-6d8f-4bcb-9782-92197f839072';
      vector integer := 82;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '29bf8c40-7341-453f-b6e8-155d1f56ff29';
      vector integer := 83;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'immigrants', 'DEM_IMM', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Immigrants'], ['fr', 'Immigrants']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := '89aa10cd-a44e-4e11-a4ff-1cf3212d1c9e';
    vector integer := 29850342;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := 'e50911e7-3194-4ca9-9516-8d051f06767e';
      vector integer := 29850347;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '9d77eb67-bb20-4c0d-913f-57ddfbb0125c';
      vector integer := 29850352;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '28f38be9-ef26-4b6d-b7b9-81701666d4e6';
      vector integer := 29850357;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '0dc88914-b886-4754-a4aa-f84a514b288b';
      vector integer := 29850362;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '389c9b3f-27d6-46df-a135-98a90bda547a';
      vector integer := 29850367;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '8e72188c-47cf-4cd4-aa31-480049cd0532';
      vector integer := 29850372;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'e1388471-136f-4866-a5a8-ebbc542bdf34';
      vector integer := 29850377;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '57071020-ca8a-4f69-b281-e721b6662dbd';
      vector integer := 29850382;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '12ed9264-e6a9-4061-b2e5-54c714dbec6f';
      vector integer := 29850387;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '494d421e-2b44-43a3-a920-d84da0884b7b';
      vector integer := 29850392;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'b7baaac1-9915-49f8-a133-ca8a9003760f';
      vector integer := 29850397;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '0c8d63b2-6763-4f05-aa0b-d377e7355b29';
      vector integer := 29850407;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'c80c70af-d084-4e17-9b09-d4bf0e5abfde';
      vector integer := 29850412;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'emigrants', 'DEM_EMI', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Emigrants'], ['fr', 'Émigrants']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := '2631a151-7902-46a1-8584-efc0042c835c';
    vector integer := 29850343;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := '501fa9f4-6cd7-4883-b1c2-60392075f5a1';
      vector integer := 29850348;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '1ff00df2-779c-44b6-af59-efd4996b1b18';
      vector integer := 29850353;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'fafbed14-bcc7-40b2-b591-10c5be61ee70';
      vector integer := 29850358;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'be877f1a-6842-4233-b694-299629390f13';
      vector integer := 29850363;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '9db9315c-adfb-43c5-9323-a185f0b6ddab';
      vector integer := 29850368;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '783503cd-994c-4423-b9de-4903bdb088b5';
      vector integer := 29850373;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a9257d61-51fe-4849-8835-8eff9f93d3e4';
      vector integer := 29850378;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a2cdec47-0616-44ec-92e6-d4956bdf79ca';
      vector integer := 29850383;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '836928c4-b6d8-4d9a-96e6-9e7e2f3aa7f8';
      vector integer := 29850388;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '35fbc38b-593e-4d64-953c-c9a717a129f9';
      vector integer := 29850393;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '590378c8-39bb-420c-83de-5404f6c323f4';
      vector integer := 29850398;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '647dac1b-5a1d-4904-8e6a-057cd6907bf3';
      vector integer := 29850408;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a13bfcad-0d53-4f18-ae18-7e3dcfd10e3f';
      vector integer := 29850413;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'emigrants_returning', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Returning emigrants'], ['fr', '']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := '612b3f3c-992d-4ebc-8a0c-7978b161a233';
    vector integer := 29850344;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := '16b8512f-6abc-4d79-be03-722c69684870';
      vector integer := 29850349;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '799c8bf7-d3f5-49d0-98cc-829bd55aeb58';
      vector integer := 29850354;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '9e6675c5-c363-4647-ab5a-e4f5c27aa297';
      vector integer := 29850359;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '37c962e0-8c98-4a38-982f-8e33a35cb703';
      vector integer := 29850364;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '4eb1e641-12d5-4270-a247-7fe4a9cc7d0a';
      vector integer := 29850369;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '6fbc7195-89d9-4901-864a-18cfe535b21a';
      vector integer := 29850374;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '039212b1-39c1-4dc2-b2d2-cb839dc46067';
      vector integer := 29850379;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '023e2327-4b6e-4c86-ae16-6cd35a7a5659';
      vector integer := 29850384;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'fb9168cd-2474-4e80-9ce6-da0afe64b3f3';
      vector integer := 29850389;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '3b906e58-3bd3-4cd7-9223-1c4b6033ff84';
      vector integer := 29850394;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '6da108e6-61f9-46d3-b9e7-67eab99c544f';
      vector integer := 29850399;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '35a30bbf-549f-4755-8021-74ab7c1136bd';
      vector integer := 29850409;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'd9afdb4a-15d5-4eba-a98f-d766ccc7327b';
      vector integer := 29850414;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'emigrants_temporary_net', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Net temporary emigrants'], ['fr', '']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := '68ec6b0d-4417-48b0-a358-266c03bf4490';
    vector integer := 29850345;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := 'acf31d39-b6b3-4e10-b6b6-0f1cde11abac';
      vector integer := 29850350;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'b7791284-25df-4c66-a4ac-e44e2d571855';
      vector integer := 29850355;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '14240ee7-352e-4662-9b55-4f0e68b38697';
      vector integer := 29850360;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'e2e8d75d-8ae4-4af8-992f-61b6cd920b8d';
      vector integer := 29850365;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '6654a417-b031-4e23-b5cf-542ed1207174';
      vector integer := 29850370;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '2966b85a-66e3-4fc2-bd8c-881851a6401c';
      vector integer := 29850375;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '04dc48c8-cee9-4e79-b9cd-8a4c8cd483ec';
      vector integer := 29850380;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '05258d97-6c87-406d-97da-15ead0f2f4fe';
      vector integer := 29850385;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '96a15248-c155-42e1-bb5b-38c750a43592';
      vector integer := 29850390;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '59c0288d-1fc2-4787-804b-57de54d4af74';
      vector integer := 29850395;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '67c32feb-40b4-441d-84e0-b1d131319ee3';
      vector integer := 29850400;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '33b73b74-6fa1-4d03-8ea6-fb007649bc67';
      vector integer := 29850410;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '57b17f66-b4b7-43e2-9069-c31218ad8487';
      vector integer := 29850415;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;

DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'non_permanent_residents_net', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Net non-permanent residents'], ['fr', '']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  DECLARE
    timeseries UUID := 'c6fe1406-5058-430e-8eed-9b665fca7b05';
    vector integer := 29850346;
    geo varchar := '01';
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);

    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
  END;


    DECLARE
      timeseries UUID := '1eca5d91-0c8c-491e-b27c-bf3e7d7679aa';
      vector integer := 29850351;
      geo varchar := '10';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '457632ba-2a59-4f64-92d8-b53398368989';
      vector integer := 29850356;
      geo varchar := '11';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '24de4cbd-29d5-488e-8be3-7ed0d62cc0c7';
      vector integer := 29850361;
      geo varchar := '12';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '6a5a4b01-a3f4-43cb-9553-b441fcecb073';
      vector integer := 29850366;
      geo varchar := '13';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'c17492d3-cb0b-4a63-8b55-bda43e7ef7ce';
      vector integer := 29850371;
      geo varchar := '24';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '4b114d7b-dc38-4273-ab1a-5d0b897a2496';
      vector integer := 29850376;
      geo varchar := '35';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '8764fc3f-7a4c-4f83-b2f6-54a1cece28ff';
      vector integer := 29850381;
      geo varchar := '46';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '5382607c-56da-47b2-b6ae-2cf1dbcdc0ab';
      vector integer := 29850386;
      geo varchar := '47';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'ade680e1-b906-452f-99d3-47682b72d3e6';
      vector integer := 29850391;
      geo varchar := '48';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'd796ac8e-b735-47ce-ae4e-87cb92084f17';
      vector integer := 29850396;
      geo varchar := '59';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := '811a6010-36fa-45a3-81cc-ec61314b01e0';
      vector integer := 29850401;
      geo varchar := '60';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'a37f6099-3603-432b-9bba-2edf95e95df9';
      vector integer := 29850411;
      geo varchar := '61';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;

    DECLARE
      timeseries UUID := 'd236215b-ce61-4519-9bd8-c5f3beb13b9d';
      vector integer := 29850416;
      geo varchar := '62';
    BEGIN
      INSERT INTO timeseries
      VALUES (timeseries, indicator_id);

      INSERT INTO vectors
      VALUES (vector, timeseries);

      INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
      VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = geo));
    END;
END; $$;


DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'interprovincial_migrants', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', 'Interprovincial Migrants'], ['fr', 'Migrant Interprovinciaux']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;


  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'population_and_demography')
  );



  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea_provinceDestination')
  );




  DECLARE
    timeseries UUID := '50777fd1-896a-4115-affb-55ff887a9bcc';
    vector integer := 32211563;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '45ea3fcc-1654-413a-9922-061233f010ba';
    vector integer := 32211564;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := '8ec4b48b-0fa0-4f29-b88f-7667cee88b9b';
    vector integer := 32211565;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := 'c58d3d6f-a690-4915-8c52-33d88e1f0502';
    vector integer := 32211566;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := 'fb71f4c7-bdd2-42f8-a784-f012407f948e';
    vector integer := 32211567;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := '917d468d-e82f-4295-9c6d-7963410fb166';
    vector integer := 32211568;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := 'c0c86837-d7a8-4c97-a590-cad7f08e2412';
    vector integer := 32211569;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := '2f1f6578-ff41-42bd-b18f-9314fa1230d2';
    vector integer := 32211570;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'cd87e2f6-c6bd-4794-8548-e186e132fc32';
    vector integer := 32211571;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := '033ba481-532e-478d-bd1e-0bc80363e368';
    vector integer := 32211572;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := '81474517-d3df-4ac9-b4a5-154cfea81959';
    vector integer := 32211574;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '79b37e5b-c047-4bcb-830c-e59e957d86c1';
    vector integer := 32211575;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '369b35c5-7818-49aa-822e-f3347192440e';
    vector integer := 32211576;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '795642a7-9563-4c4d-a689-c332feb3924c';
    vector integer := 32211577;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := '0545ca8c-3354-4ea0-9108-53642dc7b10e';
    vector integer := 32211578;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '436ed67d-22d6-4ed0-bd95-96d8aff92ee1';
    vector integer := 32211579;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := '2214af01-8295-4bb4-a9a3-717c5738ff8a';
    vector integer := 32211580;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := 'b71f0662-056d-43fc-9d69-be3945a4668f';
    vector integer := 32211581;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := 'c7234dce-1c40-4326-8243-0a1031cc3c56';
    vector integer := 32211582;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := '1e919a0b-3615-4a43-a85a-35f61431687c';
    vector integer := 32211583;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := '4a8f68d0-7d15-4e51-acaf-e965089f9c19';
    vector integer := 32211584;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := '47d7fae8-5039-4ee5-942a-51afc1440fa1';
    vector integer := 32211585;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := '1df4dd57-e4f0-40de-9d1b-368517164cd7';
    vector integer := 32211587;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '790f4a9b-c51d-450b-88f2-3f9d8f070ead';
    vector integer := 32211588;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '0a14bfd9-9b23-4c85-9895-bbf2bca54cc8';
    vector integer := 32211589;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := 'c2ce5134-8216-4200-84a2-5cb068a47112';
    vector integer := 32211590;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '9e9c92b3-884a-4f17-bb62-da24f53f15a9';
    vector integer := 32211591;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '4f967cb2-3f17-4174-a147-503ac53e8027';
    vector integer := 32211592;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := '296917bb-d1ca-449a-bf2f-45e00e9aacdb';
    vector integer := 32211593;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := '6f54b6b1-8d0a-4942-9bd5-70c0880997ef';
    vector integer := 32211594;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := 'ad3ccc43-6144-46c9-b4a9-64e2c8902226';
    vector integer := 32211595;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := 'da7ad12e-2c16-4132-9632-3f999ba890df';
    vector integer := 32211596;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'be942009-6fd9-4445-97bb-ca3d587c2563';
    vector integer := 32211597;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := 'c1eab022-31d0-4deb-93ac-dab1e0f4d0d6';
    vector integer := 32211598;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := 'c32d5ad2-1b3a-4198-b923-5a664c9c1b31';
    vector integer := 32211600;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := 'f68ba0ef-6c3d-4c82-90bc-08896a56b6f9';
    vector integer := 32211601;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := 'c6b67c42-476c-45cd-a562-dc1473a2f3f5';
    vector integer := 32211602;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := 'd7ae60e4-a436-4a72-9566-36a6c8b81031';
    vector integer := 32211603;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '0ad4ecef-b16d-472e-8868-709e3fb12240';
    vector integer := 32211604;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := '3ec54bd7-6197-4ed7-a0e4-0986a3fe2f78';
    vector integer := 32211605;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := 'a4e88ce0-841b-49b8-8992-55feb3791198';
    vector integer := 32211606;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := '62063402-cd01-44e9-b4a2-4d4fc8881b67';
    vector integer := 32211607;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := '89563423-946c-4c46-b391-5a18837dc224';
    vector integer := 32211608;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := '96d23534-761e-4d11-870e-91d114e413c5';
    vector integer := 32211609;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'a6f41f5f-e995-426c-9b1e-cdc707c089cd';
    vector integer := 32211610;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := '93b243c8-882e-4ae5-bc9a-311a8d701ce4';
    vector integer := 32211611;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := '9565d3f2-5774-458f-b492-06c86f47cf2c';
    vector integer := 32211613;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '623b2d7a-6e14-43a0-a7ae-d55b9cfc3ab7';
    vector integer := 32211614;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '64887eac-89f6-4f73-a321-9d2e19dc79ec';
    vector integer := 32211615;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '2c2afce4-6811-4419-9348-c6074288ef7b';
    vector integer := 32211616;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '65892262-4194-4653-ab02-f3e52bdf807b';
    vector integer := 32211617;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := '51bcf166-8c3d-4320-b8a9-0794bfd7484a';
    vector integer := 32211618;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '7c01df7b-9ae8-4441-9e17-944b563206d3';
    vector integer := 32211619;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := 'e8e2f8b3-6c33-4d85-9316-0febbbc1c898';
    vector integer := 32211620;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := 'a4031d7e-7e0c-479d-a428-b6e2115a917a';
    vector integer := 32211621;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := 'a0e7441b-9bcc-4613-b3f7-2b9dfe2b4527';
    vector integer := 32211622;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'b3d89b4f-92ae-4703-824e-901a4f1ec51b';
    vector integer := 32211623;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := '9aeefe60-0c5e-4e51-8e64-459b8f795f34';
    vector integer := 32211624;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := '6f04c485-7128-4072-b6a1-d417df654389';
    vector integer := 32211626;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := 'c5cbf0b1-76c4-4c8a-b476-82b2b52668f3';
    vector integer := 32211627;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '4129dcc3-c5a5-4c10-9ba8-4af11ba1a65e';
    vector integer := 32211628;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '952c5ecd-18a5-46e2-8413-8b47aaefc17a';
    vector integer := 32211629;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '23704eaf-df79-4263-aec6-8ea79ddc14c1';
    vector integer := 32211630;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := 'cdbb6b35-10f6-4e94-b85e-2261d3ccf15b';
    vector integer := 32211631;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '3cc2cb68-9071-4c10-8d95-a8e66e264304';
    vector integer := 32211632;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := '7864ad82-5d5c-4563-9193-f79f5e40ff18';
    vector integer := 32211633;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := 'f0c90c34-8dd3-4867-918d-b9ab977e5c68';
    vector integer := 32211634;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := '040d3de0-aac1-4865-b1e9-9996de7fc3a1';
    vector integer := 32211635;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := '5c3e2b4c-ce7f-4392-a069-a559d90ec120';
    vector integer := 32211636;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := '5072b422-8c69-4273-9b07-68b7b0f25735';
    vector integer := 32211637;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := 'ffe0d528-0370-475b-a81f-b689eab05af6';
    vector integer := 32211639;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '00f8e665-e369-4048-8b22-55d90920ac9e';
    vector integer := 32211640;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '8128a440-48da-4f40-a24a-49d7d9b64132';
    vector integer := 32211641;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := 'e6ed68ca-a66e-45a3-a204-09ea9c47f779';
    vector integer := 32211642;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '30c3716f-42ba-47d8-ac0b-0292684c2844';
    vector integer := 32211643;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := 'dc1405b3-9093-45b3-8583-ab9b1c4a045c';
    vector integer := 32211644;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '37f0bcac-7c87-4c9a-829a-c932ca6e706c';
    vector integer := 32211645;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := '94346c21-06bb-47fd-9c61-55409b176dc2';
    vector integer := 32211646;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := '9579017b-0d89-4ba5-8eae-21752ffd6982';
    vector integer := 32211647;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := 'd9e6166c-11b6-4848-a412-f4b9770de3b3';
    vector integer := 32211648;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := '5479e19c-8e5f-44ab-b504-9f976c8e7401';
    vector integer := 32211649;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := 'f84a89d4-20a0-4d2b-9c27-e5cbbbf79850';
    vector integer := 32211650;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := '71739960-6d9e-4325-9d3c-c8cc1d56d1b6';
    vector integer := 32211652;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '157a08be-692b-42a1-846a-6fec570f3d35';
    vector integer := 32211653;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := 'a075ecfa-6e22-4455-b32e-005e2869f6e0';
    vector integer := 32211654;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '39a974f8-c118-4895-a8d8-e9fe6c25b0ad';
    vector integer := 32211655;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '576199c5-85b4-483f-9d2f-739854fd03bb';
    vector integer := 32211656;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := 'a2dffcfb-c375-4fbc-9a43-27f0a92bad20';
    vector integer := 32211657;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '4994fcb1-c0c2-476c-b5b2-cbcb8b6e334e';
    vector integer := 32211658;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := 'ce2c99e5-f223-4d5a-96f3-d435ec803399';
    vector integer := 32211659;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := 'addf3fb0-f79f-4ae6-af15-51d054d18f0d';
    vector integer := 32211660;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := '429cfc85-1f1e-4cb5-a984-f85e92207dc1';
    vector integer := 32211661;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'ba5b4804-dc8e-4e07-9f47-2c5e05ac8c58';
    vector integer := 32211662;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := 'd98874b2-6013-460c-bea1-69afad27b68a';
    vector integer := 32211663;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := 'f8a63084-855d-40c4-98f7-9b5339c53c0d';
    vector integer := 32211665;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '9b5c5281-95e7-49e2-9b76-5d70d905a48e';
    vector integer := 32211666;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '44ad9915-f169-46ca-8c8f-f07a4f02cb47';
    vector integer := 32211667;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '35bdfbcb-98d2-4d8a-a7be-884d9cef30bd';
    vector integer := 32211668;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := 'f24be855-d71d-47d2-8737-99d61d081792';
    vector integer := 32211669;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := 'e8aaa989-65c2-4b9d-b181-6c99d145dadf';
    vector integer := 32211670;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '67d23263-c592-4fde-ae91-bdf8e478bf14';
    vector integer := 32211671;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := 'c55e0209-8870-4e9a-8400-401e792f5dd1';
    vector integer := 32211672;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := '6bbc0942-661b-461c-a6af-ffc2bdc9b550';
    vector integer := 32211673;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := '18122c25-0e7c-4f4c-8118-c2e6621ad3f1';
    vector integer := 32211674;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := '7eba3380-d0c8-4b3d-b58b-9a36c96e9e33';
    vector integer := 32211675;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := 'b67e1856-93b0-4434-80d8-f7aba964a0a2';
    vector integer := 32211676;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := '0d81afe2-3343-4b67-8c01-ab3570cac04a';
    vector integer := 32211678;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '01dbbe9f-6e7d-4c8b-a503-2c020d802bfd';
    vector integer := 322116679;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '540d0f6b-fa2d-49a0-803c-3066d94ba971';
    vector integer := 32211680;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '98195356-2105-4461-ad47-ed865c656124';
    vector integer := 32211681;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := 'f6493c5c-020c-4b35-b002-c36303787834';
    vector integer := 32211682;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := '41619ee7-05bb-4555-8996-bdad34eb815e';
    vector integer := 32211683;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '69cc3c98-8004-4f10-ba20-45a07c590756';
    vector integer := 32211684;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := 'b9e53ce7-85ce-408a-8ce7-57845f08e43a';
    vector integer := 32211685;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := 'ccfd6f88-be9f-42dc-9643-01371c96f83d';
    vector integer := 32211686;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := '0f699ba6-95e2-4567-b7fd-31488aa0187e';
    vector integer := 322116687;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := 'd038e71c-31bd-449c-bb14-541210f12f01';
    vector integer := 32211688;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'e765823a-2eaa-4299-ac36-1446b9c87b83';
    vector integer := 32211689;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := 'e9f837f4-4f79-4235-91a6-7f7d13a66f79';
    vector integer := 32211691;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := '261a6fa3-1e25-4af1-92ae-d23dd47c3d4e';
    vector integer := 322116692;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '40d9b805-7dc3-40bc-9011-380ba3ee46ae';
    vector integer := 322116693;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '535160e7-f696-49d7-8885-0696ee401b47';
    vector integer := 32211694;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := '0ae03ab9-21cc-4ce1-bd8d-e78158d215a7';
    vector integer := 322116695;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := '890080e7-3eb0-4a00-9cf3-deb85deb93f9';
    vector integer := 32211696;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '43ed13a0-5ee5-47ee-956a-249cd5818f75';
    vector integer := 32211697;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := '47336e2b-1ec0-4bcd-b6e9-5b3adbc76bbc';
    vector integer := 32211698;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := '0378e5f9-808a-4753-b31e-7728c7c2ae15';
    vector integer := 32211699;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := '72d4945a-fa7d-45dc-b49b-6c4e5a783035';
    vector integer := 32211700;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := 'b25756a4-c6bc-4c07-b101-caff85c5ad33';
    vector integer := 32211701;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := '31046d1d-b557-4e69-9bb5-13fbbc0ebddd';
    vector integer := 32211702;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := '77a1decf-8aae-4cb6-b89d-c15dbef34174';
    vector integer := 32211704;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

  END;

  DECLARE
    timeseries UUID := 'f71edb36-3c16-4a4c-b647-7c47df22e10a';
    vector integer := 32211705;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;

  DECLARE
    timeseries UUID := '751a7e58-de9a-4557-b6de-ad09bd8746a0';
    vector integer := 32211717;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '10'));

  END;

  DECLARE
    timeseries UUID := '67c4e81c-465d-48e6-a832-9176dc71bd2a';
    vector integer := 32211718;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '11'));

  END;

  DECLARE
    timeseries UUID := 'b4c3b7d1-8706-4e0f-a215-6cca77d6841b';
    vector integer := 32211719;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '12'));

  END;

  DECLARE
    timeseries UUID := 'd42855b7-d4a2-4b25-b892-0d395cc027f2';
    vector integer := 32211720;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '13'));

  END;

  DECLARE
    timeseries UUID := '17933b96-d0ab-4778-8901-505d691e423d';
    vector integer := 32211721;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '24'));

  END;

  DECLARE
    timeseries UUID := '87b4b532-2fa4-4a49-a82f-d656d3f411e8';
    vector integer := 32211722;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35'));

  END;

  DECLARE
    timeseries UUID := 'd24acb32-4fb9-40f7-8185-87dac4283231';
    vector integer := 32211723;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '46'));

  END;

  DECLARE
    timeseries UUID := '8cb5a873-4f09-4a37-b320-2c0eefef9d98';
    vector integer := 32211724;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '47'));

  END;

  DECLARE
    timeseries UUID := '7f32ef0b-5be6-4dcb-a584-0496a4eaea23';
    vector integer := 32211725;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '48'));

  END;

  DECLARE
    timeseries UUID := 'b125a296-4ed3-4979-95e3-4a574fdcda44';
    vector integer := 32211726;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '59'));

  END;

  DECLARE
    timeseries UUID := 'a5a86a0e-9b32-45f0-bef3-b5f5e62e7278';
    vector integer := 32211727;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '60'));

  END;

  DECLARE
    timeseries UUID := 'f9c44328-91a6-4950-bec8-430f564ec897';
    vector integer := 32211728;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '61'));

    INSERT INTO timeseries_dimension_geographicArea_provinceDestination (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '62'));

  END;
END; $$;

REFRESH MATERIALIZED VIEW "mvTimeseriesDimensions";
