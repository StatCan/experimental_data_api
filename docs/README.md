# Statistics Canada API Documentation #

## EndPoints ##

*   [Indicators](#indicators)
*   [Observations](#observations)
*   [Timeseries](#timeseries)
*   [Sources](#sources)
*   [Revisions](#revisions)
*   [Notes](#notes)
*   [Legacy](#legacy)

### Indicators ###

#### List indicators ####

```
GET /indicators
```

###### Response ######

```json
[
  {
    "type": "indicator",
    "id": "death",
    "attributes": {
      "sdmxId": "DEM_DTH",
      "title": {
        "en": "Deaths",
        "fr": "Décès"
      },
      "frequency": "quarterly",
      "temporalCoverage": "1946-01-01/2018-10-01",
      "dimensions": [
        "geographicArea"
      ],
      "dateModified": "2018-06-14"
    },
    "links": {
      "self": "https://api.statcan.gc.ca/indicators/death",
    },
    "relationships": {
      "observations": {
        "links": {
          "self": "https://api.statcan.gc.ca/indicators/death/observations"
        }
      },
      "timeseries": {
        "links": {
          "self": "https://api.statcan.gc.ca/indicators/death/timeseries"
        }
      }
    }
  }
]
```

### Get a single indicator ###

```
GET /indicators/:indicator
```

###### Response ######

```json
{
  "type": "indicator",
  "id": "death",
  "attributes": {
    "sdmxId": "DEM_DTH",
    "title": {
      "en": "Deaths",
      "fr": "Décès"
    },
    "frequency": "quarterly",
    "temporalCoverage": "1946-01-01/2018-10-01",
    "dimensions": [
      "geographicArea"
    ],
    "dateModified": "2018-06-14"
  },
  "links": {
    "self": "https://api.statcan.gc.ca/indicators/death",
  },
  "relationships": {
    "observations": {
      "links": {
        "self": "https://api.statcan.gc.ca/indicators/death/observations"
      }
    },
    "timeseries": {
      "links": {
        "self": "https://api.statcan.gc.ca/indicators/death/timeseries"
      }
    }
  }
}
```

### List observations for an indicator ###

```
GET /indicators/:indicator/observations
```

###### Parameteres ######

| Name | Type | Description |
|---|---|---|
| period | string | A range of reference period. This range must be in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM(-DD)/YYYY-MM(-DD)`. Ex: `period=2008-01/2008-10` |
| dimensions[:dimension_name] | string | Specify the dimension_name:value pair. Ex: `dimensions[geographicArea]=ON`. You can specify multiple value by repeating the parameter or via a comma-seperated value. Ex: `dimensions[geographicArea]=QC&dimensions[geographicArea]=ON` or `dimensions[geographicArea]=QC,ON` |

###### Response ######

```json
[
  {
    "type": "observation",
    "id": "f7e24559-8e5e-463b-a521-d9bdaca2d03c",
    "attributes": {
      "period": "2018-01-01",
      "dimensions": {
        "geographicArea": {
          "@type":"iso-3166-1",
          "@id":"CA"
        }
      },
      "value": 78907,
      "dateModified": "2018-06-14"
    },
    "links": {
      "self": "https://api.statcan.gc.ca/observations/79687078"
    },
    "relationships": {
      "revisions": {
        "links": {
          "self": "https://api.statcan.gc.ca/observations/79687078/revisions"
        }
      },
      "notes": {
        "links": {
          "self": "https://api.statcan.gc.ca/observations/79687078/notes"
        }
      },
      "indicator": {
        "links": {
          "self": "https://api.statcan.gc.ca/indicators/death"
        },
        "data": {
          "type": "indicator",
          "id": "death"
        }
      },
      "timeseries": {
        "links": {
          "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5"
        },
        "data": {
          "type": "timeseries",
          "id": "648fbd4a-64b0-449d-83d9-539cfa4b83e5"
        }
      }
    }
  }
]
```

### Observations ###

#### List observations ####

```
GET /observations
```

###### Parameteres ######

| Name | Type | Description |
|---|---|---|
| indicator | string | The name of the indicator |
| timeseries | string | The id of the timeseries |
| period | string | A range of reference period. This range must be in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM(-DD)/YYYY-MM(-DD)`. Ex: `period=2008-01/2008-10` |
| dimensions[:dimension_name] | string | Specify the dimension_name:value pair. Ex: `dimensions[geographicArea]=ON`. You can specify multiple value by repeating the parameter or via a comma-seperated value. Ex: `dimensions[geographicArea]=QC&dimensions[geographicArea]=ON` or `dimensions[geographicArea]=QC,ON` |

###### Response ######

```json
[
  {
    "type": "observation",
    "id": "f7e24559-8e5e-463b-a521-d9bdaca2d03c",
    "attributes": {
      "period": "2018-01-01",
      "dimensions": {
        "geographicArea": {
          "@type":"iso-3166-1",
          "@id":"CA"
        }
      },
      "value": 78907,
      "dateModified": "2018-06-14"
    },
    "links": {
      "self": "https://api.statcan.gc.ca/observations/79687078"
    },
    "relationships": {
      "revisions": {
        "links": {
          "self": "https://api.statcan.gc.ca/observations/79687078/revisions"
        }
      },
      "notes": {
        "links": {
          "self": "https://api.statcan.gc.ca/observations/79687078/notes"
        }
      },
      "indicator": {
        "links": {
          "self": "https://api.statcan.gc.ca/indicators/death"
        },
        "data": {
          "type": "indicator",
          "id": "death"
        }
      },
      "timeseries": {
        "links": {
          "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5"
        },
        "data": {
          "type": "timeseries",
          "id": "648fbd4a-64b0-449d-83d9-539cfa4b83e5"
        }
      }
    }
  }
]
```

###### Example Calls ######

Get all observations for an indicator

```
GET /observations?indicator=death
```

Get all observations in a time range (using ISO 8601)

```
GET /observations?date=2007-03-01T13:00:00Z/2008-05-11T15:30:00Z
```

### Get a single observation ###

```
GET /observations/:observation_id
```

###### Response ######

```json
{
  "type": "observation",
  "id": "f7e24559-8e5e-463b-a521-d9bdaca2d03c",
  "attributes": {
    "period": "2018-01-01",
    "dimensions": {
      "geographicArea": {
        "@type":"iso-3166-1",
        "@id":"CA"
      }
    },
    "value": 78907,
    "dateModified": "2018-06-14"
  },
  "links": {
    "self": "https://api.statcan.gc.ca/observations/79687078"
  },
  "relationships": {
    "revisions": {
      "links": {
        "self": "https://api.statcan.gc.ca/observations/79687078/revisions"
      }
    },
    "notes": {
      "links": {
        "self": "https://api.statcan.gc.ca/observations/79687078/notes"
      }
    },
    "indicator": {
      "links": {
        "self": "https://api.statcan.gc.ca/indicators/death"
      },
      "data": {
        "type": "indicator",
        "id": "death"
      }
    },
    "timeseries": {
      "links": {
        "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5"
      },
      "data": {
        "type": "timeseries",
        "id": "648fbd4a-64b0-449d-83d9-539cfa4b83e5"
      }
    }
  }
}
```

### Timeseries ###

#### List timeseries ####

```
GET /timeseries
```

###### Response ######

```json
[
  {
    "type": "timeseries",
    "id": "648fbd4a-64b0-449d-83d9-539cfa4b83e5",
    "attributes": {
      "dimensions": {
        "geographicArea": "10"
      }
    },
    "links": {
      "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5"
    },
    "relationships": {
      "observations": {
        "links": {
          "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5/observations"
        }
      },
      "indicator": {
        "links": {
          "self": "https://api.statcan.gc.ca/indicator/births"
        }
      }
    }
  }
]
```

### Get a single indicator ###

```
GET /timeserie/:timeserie
```

###### Response ######

```json
{
  "type": "timeseries",
  "id": "648fbd4a-64b0-449d-83d9-539cfa4b83e5",
  "attributes": {
    "dimensions": {
      "geographicArea": "10"
    }
  },
  "links": {
    "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5"
  },
  "relationships": {
    "observations": {
      "links": {
        "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5/observations"
      }
    },
    "indicator": {
      "links": {
        "self": "https://api.statcan.gc.ca/indicator/births"
      }
    }
  }
}
```

### List observations for an timeseries ###

```
GET /timeseries/:timeseries/observations
```

###### Parameteres ######

| Name | Type | Description |
|---|---|---|
| period | string | A range of reference period. This range must be in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM(-DD)/YYYY-MM(-DD)`. Ex: `period=2008-01/2008-10` |
| dimensions[:dimension_name] | string | Specify the dimension_name:value pair. Ex: `dimensions[geographicArea]=ON`. You can specify multiple value by repeating the parameter or via a comma-seperated value. Ex: `dimensions[geographicArea]=QC&dimensions[geographicArea]=ON` or `dimensions[geographicArea]=QC,ON` |

###### Response ######

```json
[
  {
    "type": "observation",
    "id": "f7e24559-8e5e-463b-a521-d9bdaca2d03c",
    "attributes": {
      "period": "2018-01-01",
      "dimensions": {
        "geographicArea": {
          "@type":"iso-3166-1",
          "@id":"CA"
        }
      },
      "value": 78907,
      "dateModified": "2018-06-14"
    },
    "links": {
      "self": "https://api.statcan.gc.ca/observations/79687078"
    },
    "relationships": {
      "revisions": {
        "links": {
          "self": "https://api.statcan.gc.ca/observations/79687078/revisions"
        }
      },
      "notes": {
        "links": {
          "self": "https://api.statcan.gc.ca/observations/79687078/notes"
        }
      },
      "indicator": {
        "links": {
          "self": "https://api.statcan.gc.ca/indicators/death"
        },
        "data": {
          "type": "indicator",
          "id": "death"
        }
      },
      "timeseries": {
        "links": {
          "self": "https://api.statcan.gc.ca/timeseries/648fbd4a-64b0-449d-83d9-539cfa4b83e5"
        },
        "data": {
          "type": "timeseries",
          "id": "648fbd4a-64b0-449d-83d9-539cfa4b83e5"
        }
      }
    }
  }
]
```

### Sources ###

#### List sources ####

```
GET /sources
```

###### Response ######

```json
[
  {
    "type": "source",
    "id": "population_estimates",
    "attributes": {
      "sourceType": "survey",
      "name": {
        "en": "Quarterly Demographic Estimates",
        "fr": "Estimations démographiques trimestrielles"
      },
      "frequency": "quarterly",
      "dateModified": "2018-06-14"
    },
    "links": {
      "self": "https://api.statcan.gc.ca/sources/population_estimates",
      "indicators": "https://api.statcan.gc.ca/sources/population_estimates/indicators"
    }
  }
]
```

### Get a single source ###

```
GET /sources/:source_id
```

###### Response ######

```json
{
  "type": "source",
  "id": "population_estimates",
  "attributes": {
    "sourceType": "survey",
    "name": {
      "en": "Quarterly Demographic Estimates",
      "fr": "Estimations démographiques trimestrielles"
    },
    "frequency": "quarterly",
    "dateModified": "2018-06-14"
  },
  "links": {
    "self": "https://api.statcan.gc.ca/sources/population_estimates",
    "indicators": "https://api.statcan.gc.ca/sources/population_estimates/indicators"
  }
}
```

### Revisions ###

#### List revision ####

```
GET /revisions
```

###### Response ######

```json
[
  {
    "type": "revision",
    "id": 45656,
    "attributes": {}
  }
]
```

### Get a single revision ###

```
GET /revisions/:revision_id
```

###### Response ######

```json
{
  "type": "revision",
  "id": 45656,
  "attributes": {}
}
```

### Notes ###

#### List notes ####

```
GET /notes
```

###### Response ######

```json
[
  {
    "type": "note",
    "id": 35645,
    "attributes": {}
  }
]
```

### Get a single note ###

```
GET /notes/:note_id
```

###### Response ######

```json
{
  "type": "note",
  "id": 35645,
  "attributes": {}
}
```

### Legacy ###

#### List vectors ####

```
GET /legacy/vectors
```

###### Response ######

```json
[
  {
    "type": "vector",
    "id": 1,
    "links": {
      "self": "https://api.statcan.gc.ca/timeseries/8336e328-7c42-4d78-a3a1-a96a4c3399af"
    },
    "attributes": {
      "timeseries": "8336e328-7c42-4d78-a3a1-a96a4c3399af"
    }
  }
]
```

### Get a vector ###

```
GET /legacy/vectors/:vector_id
```

This endpoints redirect the legacy vectors to the equivalent query for this API.

#### Sample Call ####

```
GET /legacy/vectors/77
```

Redirects to

```
GET /indicators/death/observations?geographicArea=CA
```

## URLs Equivalencies ##

```
/indicators/:indicator/observations = /observations?indicator=:indicator
/sources/:source/indicators = /indicators?source=:source
/observations/:observation_id/revisions = /revisions?observation_id=::observation_id
/observations/:observation_id/notes = /notes?observation_id=::observation_id
```
