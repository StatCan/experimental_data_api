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
  'flightSector',
  hstore(ARRAY[['en', 'Flight Sector'], ['fr', '']])
),
(
  'airFareTypeGroup',
  hstore(ARRAY[['en', ' Air fare type group'], ['fr', 'Groupe tarifaire aérien']])
)
