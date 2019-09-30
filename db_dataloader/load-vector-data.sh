
count=400

get_vector () {
  local vector=${1}
  curl \
    -Ssl -X POST \
    -H "Content-Type: application/json" \
    -d "[{\"vectorId\":${vector}, \"latestN\":${count}}]" \
    https://www150.statcan.gc.ca/t1/wds/rest/getDataFromVectorsAndLatestNPeriods \
    | jq -r '.[0].object.vectorDataPoint[] | [.refPer, (.value|tostring), .releaseTime] | join(",")' \
    | while read point; do
      ref=$(echo ${point} | cut -d ',' -f1)
      val=$(echo ${point} | cut -d ',' -f2)
      mod=$(echo ${point} | cut -d ',' -f3)
      echo "DO \$\$
      DECLARE
        point_id UUID;
        refperiod date := to_date('${ref}', 'YYYY-MM-DD');
        vector integer := ${vector};
        ts timestamp := timestamp '${mod}' at time zone 'America/Toronto';
      BEGIN
      WITH point AS (
        INSERT INTO observations (period, timeseries_id)
        VALUES (refperiod, (SELECT timeseries_id FROM vectors WHERE id = vector))
        RETURNING id
      )
      SELECT id INTO point_id FROM point;

      INSERT INTO observation_values (observation_id, value, \"date\")
      VALUES (point_id, ${val}, ts);
      END; \$\$;" | psql -1
    done
}

if [ ! -z ${1} ]; then
  get_vector ${1}
else
  psql -At -P pager=off -c "select id from vectors" \
  | while read vector; do
    get_vector ${vector}
  done
fi
