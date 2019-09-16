#!/bin/sh
source ./fn.sh

echo "Loading frequencies"
psql -q -c 'INSERT INTO frequencies (name, sdmx_id, title)
VALUES
(
  '"'"'annual'"'"', '"'"'A'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Annual'"'"'], ['"'"'fr'"'"', '"'"'Annuelle'"'"']])
),
(
  '"'"'semester'"'"', '"'"'S'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Half-yearly, semester'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'quarterly'"'"', '"'"'Q'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Quarterly'"'"'], ['"'"'fr'"'"', '"'"'Trimestriel'"'"']])
),
(
  '"'"'monthly'"'"', '"'"'M'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Monthly'"'"'], ['"'"'fr'"'"', '"'"'Mensuel'"'"']])
),
(
  '"'"'weekly'"'"', '"'"'W'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Weekly'"'"'], ['"'"'fr'"'"', '"'"'Hebdomadaire'"'"']])
),
(
  '"'"'daily'"'"', '"'"'D'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Daily'"'"'], ['"'"'fr'"'"', '"'"'Quotidien'"'"']])
),
(
  '"'"'hourly'"'"', '"'"'H'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Hourly'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'business_daily'"'"', '"'"'B'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Daily, business week'"'"'], ['"'"'fr'"'"', '"'"''"'"']])
),
(
  '"'"'occasional'"'"', '"'"'X'"'"',
  hstore(ARRAY[['"'"'en'"'"', '"'"'Occasional'"'"'], ['"'"'fr'"'"', '"'"'Occasionnelle'"'"']])
);'
