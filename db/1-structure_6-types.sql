CREATE TYPE sex AS ENUM(
  'male', '
  female',
  'all'
);

CREATE TYPE flightSector AS ENUM(
  'domestic_and_international',
  'domestic',
  'international',
  'shortHaul',
  'longHaul'
);

CREATE TYPE airFareTypeGroup AS ENUM(
  'all',
  'business',
  'economy',
  'discounted',
  'other'
);
