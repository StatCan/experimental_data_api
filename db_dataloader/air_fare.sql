
DO $$
DECLARE
  indicator_id integer;
BEGIN
  WITH indicator AS (
    INSERT INTO indicators (name, sdmx_id, frequency_id, title)
    VALUES
    (
      'airFares', '', (SELECT id FROM frequencies WHERE name = 'quarterly'),
      hstore(ARRAY[['en', ''], ['fr', '']])
    )
    RETURNING id
  )
  SELECT id INTO indicator_id FROM indicator;


  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'transportation')
  );

  INSERT INTO indicator_subjects (indicator_id, subject_id)
  VALUES (
    indicator_id,
    (SELECT id FROM subjects WHERE name = 'prices_and_price_indexes')
  );



  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'airFareTypeGroup')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'flightSector')
  );

  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    indicator_id,
    (SELECT id FROM dimensions WHERE name = 'geographicArea')
  );




  DECLARE
    timeseries UUID := '4b3083ed-a42f-4b6c-98b9-9b21e227bfc1';
    vector integer := 53508617;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic_and_international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '370a18b3-0a36-47a8-a18b-dda54bf708ec';
    vector integer := 53508618;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic_and_international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'business'));

  END;

  DECLARE
    timeseries UUID := 'ed103259-57c2-4b93-b559-1ea495acf3ab';
    vector integer := 53508619;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic_and_international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'economy'));

  END;

  DECLARE
    timeseries UUID := '213b507f-ca4e-4534-a329-67bcb698be59';
    vector integer := 53508620;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic_and_international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'discounted'));

  END;

  DECLARE
    timeseries UUID := 'a684daeb-de34-444a-995a-34853f561bb5';
    vector integer := 53508621;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic_and_international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'other'));

  END;

  DECLARE
    timeseries UUID := '0b2b6027-8bc3-4203-af24-3a32fdf21af3';
    vector integer := 53508622;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := 'b96f6782-55cc-4e26-844b-9ffbd18f2cc3';
    vector integer := 53508623;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'business'));

  END;

  DECLARE
    timeseries UUID := '947cfaeb-9e39-476b-8ed5-fc8a7edb0504';
    vector integer := 53508624;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'economy'));

  END;

  DECLARE
    timeseries UUID := 'c56bcae4-bf6b-47a9-a201-aba68647c4c2';
    vector integer := 53508625;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'discounted'));

  END;

  DECLARE
    timeseries UUID := '36336cdf-a53d-41d0-a48b-fe91e6ffaaec';
    vector integer := 53508626;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'other'));

  END;

  DECLARE
    timeseries UUID := 'cea391a2-bf90-4ede-9409-01e77ffeb092';
    vector integer := 53508627;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'shortHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '73690c12-d430-4f81-9c8f-08c307f199fb';
    vector integer := 53508628;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'shortHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'business'));

  END;

  DECLARE
    timeseries UUID := '60276c6a-092b-4e9e-ac1b-acb9680bebee';
    vector integer := 53508629;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'shortHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'economy'));

  END;

  DECLARE
    timeseries UUID := '1afe00d4-b124-4569-85d2-1adb707fe105';
    vector integer := 53508630;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'shortHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'discounted'));

  END;

  DECLARE
    timeseries UUID := 'b32941a6-04c4-4761-8993-82f6644a81b1';
    vector integer := 53508631;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'shortHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'other'));

  END;

  DECLARE
    timeseries UUID := '1a64e9ce-b724-453d-997f-6e93a9b834e5';
    vector integer := 53508632;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'longHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := 'fc45d5c5-fab0-4ff1-9a5b-264a0b220298';
    vector integer := 53508633;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'longHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'business'));

  END;

  DECLARE
    timeseries UUID := 'f6b6761e-9963-4641-ac97-33ed7a63f081';
    vector integer := 53508634;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'longHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'economy'));

  END;

  DECLARE
    timeseries UUID := '349d1122-324c-4386-9fde-bc77b06a34bc';
    vector integer := 53508635;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'longHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'discounted'));

  END;

  DECLARE
    timeseries UUID := '8672de61-ec1c-4ee1-a53c-4ac5ecf5e433';
    vector integer := 53508636;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'longHaul'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'other'));

  END;

  DECLARE
    timeseries UUID := '2ba2caeb-ef02-4f55-ae32-2b52f0b935ac';
    vector integer := 53508637;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := 'a89db49b-c1ff-4f2f-8e20-24a384213c68';
    vector integer := 53508638;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'business'));

  END;

  DECLARE
    timeseries UUID := '05bb7687-2d93-40a3-a983-a5a2fa197e25';
    vector integer := 53508639;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'economy'));

  END;

  DECLARE
    timeseries UUID := 'a7e9fdf7-c2e9-4826-9c63-7309d8287cbd';
    vector integer := 53508640;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'discounted'));

  END;

  DECLARE
    timeseries UUID := 'b2a0179f-5b18-4d3d-863f-e7606857bebe';
    vector integer := 53508641;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '01'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'international'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'other'));

  END;

  DECLARE
    timeseries UUID := '089302ae-d933-48fa-9377-ef355fcb1133';
    vector integer := 812700;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '205'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := 'd8313ad4-3ded-4e22-a6c1-c3cf84f545c0';
    vector integer := 812699;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '462'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := 'b749b0df-5542-4447-aba4-c8ef3f859972';
    vector integer := 812698;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '35505'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '810beb46-6c7e-453f-9ae4-752cca97259b';
    vector integer := 812697;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '535'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '7621e978-d179-42cb-aad9-45769afa31ea';
    vector integer := 812696;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '602'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '0d303ead-e5fa-4329-b61e-cc934623e6ab';
    vector integer := 812695;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '725'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '071efb49-1300-45e2-96f7-ccfe3bbf0ce9';
    vector integer := 812694;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '705'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '25ce0b61-0a2d-4d5e-adf5-a8c1027301af';
    vector integer := 812693;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '825'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := '0d7be7f4-b8e2-4d29-90d0-ae776d00f461';
    vector integer := 812692;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '835'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;

  DECLARE
    timeseries UUID := 'b44a3e46-1c54-41bb-9135-afce9507840b';
    vector integer := 812691;
  BEGIN
    INSERT INTO timeseries
    VALUES (timeseries, indicator_id);

    INSERT INTO vectors
    VALUES (vector, timeseries);


    INSERT INTO timeseries_dimension_geographicArea (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_geographicArea WHERE name = '933'));

    INSERT INTO timeseries_dimension_flightSector (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_flightSector WHERE name = 'domestic'));

    INSERT INTO timeseries_dimension_airFareTypeGroup (timeseries_id, value_id)
    VALUES (timeseries, (SELECT id FROM type_airFareTypeGroup WHERE name = 'all'));

  END;
END; $$;

REFRESH MATERIALIZED VIEW "mvTimeseriesDimensions";
