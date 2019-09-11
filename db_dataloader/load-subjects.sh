#!/bin/sh
source fn.sh

echo "Loading subjects"
psql -q -c 'INSERT INTO subjects (name, title)
VALUES
(
  '"'"'aboriginal_peoples'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Aboriginal peoples'"'"'], ['"'"'fr'"'"', '"'"'Peuples autochtones'"'"']])
),
(
  '"'"'agriculture'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Agriculture'"'"'], ['"'"'fr'"'"', '"'"'Agriculture'"'"']])
),
(
  '"'"'business_and_consumer_services_and_culture'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Business and consumer services and culture'"'"'], ['"'"'fr'"'"', '"'"'Services aux entreprises et aux consommateurs et culture'"'"']])
),
(
  '"'"'business_performance_and_ownership'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Business performance and ownership'"'"'], ['"'"'fr'"'"', '"'"'Rendement des entreprises et appartenance'"'"']])
),
(
  '"'"'children_and_youth'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Children and youth'"'"'], ['"'"'fr'"'"', '"'"'Enfants et jeunes'"'"']])
),
(
  '"'"'construction'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Construction'"'"'], ['"'"'fr'"'"', '"'"'Construction'"'"']])
),
(
  '"'"'crime_and_justice'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Crime and justice'"'"'], ['"'"'fr'"'"', '"'"'Crime et justice'"'"']])
),
(
  '"'"'economic_accounts'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Economic accounts'"'"'], ['"'"'fr'"'"', '"'"'Comptes économiques'"'"']])
),
(
  '"'"'education_training_and_learning'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Education, training and learning'"'"'], ['"'"'fr'"'"', '"'"'Éducation, formation et apprentissage'"'"']])
),
(
  '"'"'energy'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Energy'"'"'], ['"'"'fr'"'"', '"'"'Énergie'"'"']])
),
(
  '"'"'environment'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Environment'"'"'], ['"'"'fr'"'"', '"'"'Environnement'"'"']])
),
(
  '"'"'families_and_households'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Families and households'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'government'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Government'"'"'], ['"'"'fr'"'"', '"'"'Gouvernement'"'"']])
),
(
  '"'"'health'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Health'"'"'], ['"'"'fr'"'"', '"'"'Santé'"'"']])
),
(
  '"'"'housing'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Housing'"'"'], ['"'"'fr'"'"', '"'"'Logement'"'"']])
),
(
  '"'"'immigration_and_ethnocultural_diversity'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Immigration and ethnocultural diversity'"'"'], ['"'"'fr'"'"', '"'"'Immigration et diversité ethnoculturelle'"'"']])
),
(
  '"'"'income_pensions_spending_and_wealth'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Income, pensions, spending and wealth'"'"'], ['"'"'fr'"'"', '"'"'Revenu, pensions, dépenses et richesse'"'"']])
),
(
  '"'"'information_and_communications_technology'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Information and communications technology'"'"'], ['"'"'fr'"'"', '"'"'Technologies de l'"'"''"'"'information et des communications'"'"']])
),
(
  '"'"'international_trade'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'International trade'"'"'], ['"'"'fr'"'"', '"'"'Commerce international'"'"']])
),
(
  '"'"'labour'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Labour'"'"'], ['"'"'fr'"'"', '"'"'Travail'"'"']])
),
(
  '"'"'languages'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Languages'"'"'], ['"'"'fr'"'"', '"'"'Langues'"'"']])
),
(
  '"'"'manufacturing'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Manufacturing'"'"'], ['"'"'fr'"'"', '"'"'Fabrication'"'"']])
),
(
  '"'"'population_and_demography'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Population and demography'"'"'], ['"'"'fr'"'"', '"'"'Population et démographie'"'"']])
),
(
  '"'"'prices_and_price_indexes'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Prices and price indexes'"'"'], ['"'"'fr'"'"', '"'"'Prix et indices des prix'"'"']])
),
(
  '"'"'retail_and_wholesale'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Retail and wholesale'"'"'], ['"'"'fr'"'"', '"'"'Commerce de détail et de gros'"'"']])
),
(
  '"'"'science_and_technology'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Science and technology'"'"'], ['"'"'fr'"'"', '"'"'Sciences et technologie'"'"']])
),
(
  '"'"'seniors'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Seniors'"'"'], ['"'"'fr'"'"', '"'"'Aînés'"'"']])
),
(
  '"'"'society_and_community'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Society and community'"'"'], ['"'"'fr'"'"', '"'"'Société et communauté'"'"']])
),
(
  '"'"'statistical_methods'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Statistical methods'"'"'], ['"'"'fr'"'"', '"'"'Méthodes statistiques'"'"']])
),
(
  '"'"'transportation'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Transportation'"'"'], ['"'"'fr'"'"', '"'"'Transport'"'"']])
),
(
  '"'"'travel_and_tourism'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Travel and tourism'"'"'], ['"'"'fr'"'"', '"'"'Voyages et tourisme'"'"']])
);'
