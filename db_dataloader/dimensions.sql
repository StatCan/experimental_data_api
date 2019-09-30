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
  'seasonallyAdjusted',
  hstore(ARRAY[['en', 'Seasonally Adjusted'], ['fr', 'Désaisonnalisées']])
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
),
(
  'consumerPriceProduct',
  hstore(ARRAY[['en', 'Consumer price products and product groups'], ['fr', 'Produits et groupes de produits de consommation']])
),
(
  'priceBaseDate',
  hstore(ARRAY[['en', 'Price Base Date'], ['fr', 'Date du prix de base']])
),
(
  'weightPricePeriod',
  hstore(ARRAY[['en', 'Price period of weight'], ['fr', 'Période du prix de la pondération']])
),
(
  'weightGeographicDistribution',
  hstore(ARRAY[['en', 'Geographic distribution of weight'], ['fr', 'Distribution géographique de la pondération']])
);
