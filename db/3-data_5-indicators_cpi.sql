
INSERT INTO indicators (name, sdmx_id, frequency_id, title)
VALUES
(
  'consumer_price_index', '', (SELECT id FROM frequencies WHERE name = 'monthly'),
  hstore(ARRAY[['en', 'Consumer Price Index'], ['fr', 'Indice des prix à la consommation']])
);

DO $$
DECLARE
  ind varchar = 'consumer_price_index';
  dim varchar;
BEGIN
FOREACH dim IN ARRAY ARRAY['geographicArea', 'consumerPriceProduct', 'priceBaseDate', 'seasonallyAdjusted']
LOOP
  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    (SELECT id FROM indicators WHERE name = ind),
    (SELECT id FROM dimensions WHERE name = dim)
  );
END LOOP;
INSERT INTO indicator_subjects (indicator_id, subject_id)
VALUES (
  (SELECT id FROM indicators WHERE name = ind),
  (SELECT id FROM subjects WHERE name = 'prices_and_price_indexes')
);
END; $$;

INSERT INTO indicators (name, sdmx_id, frequency_id, title)
VALUES
(
  'consumer_price_weight', '', (SELECT id FROM frequencies WHERE name = 'occasional'),
  hstore(ARRAY[['en', 'Basket weights of the Consumer Price Index'], ['fr', 'Pondérations du panier de l\x27Indice des prix à la consommation']])
);

DO $$
DECLARE
  ind varchar = 'consumer_price_weight';
  dim varchar;
BEGIN
FOREACH dim IN ARRAY ARRAY['geographicArea', 'consumerPriceProduct', 'weightPricePeriod', 'weightGeographicDistribution']
LOOP
  INSERT INTO indicator_dimensions (indicator_id, dimension_id)
  VALUES (
    (SELECT id FROM indicators WHERE name = ind),
    (SELECT id FROM dimensions WHERE name = dim)
  );
END LOOP;
INSERT INTO indicator_subjects (indicator_id, subject_id)
VALUES (
  (SELECT id FROM indicators WHERE name = ind),
  (SELECT id FROM subjects WHERE name = 'prices_and_price_indexes')
);
END; $$;
