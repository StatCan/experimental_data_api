INSERT INTO dimensions (name, title)
VALUES
(
  'period',
  hstore(ARRAY[['en', 'Refrence Period'], ['fr', '']])
),
(
  'geographicArea',
  hstore(ARRAY[['en', 'Geography'], ['fr', 'Géography']])
),
(
  'geographicArea_provinceDestination',
  hstore(ARRAY[['en', 'Geography, province of destination'], ['fr', 'Géographie, province de destination']])
),
(
  'flightSector',
  hstore(ARRAY[['en', 'Flight Sector'], ['fr', '']])
),
(
  'airFareTypeGroup',
  hstore(ARRAY[['en', ' Air fare type group'], ['fr', 'Groupe tarifaire aérien']])
)
