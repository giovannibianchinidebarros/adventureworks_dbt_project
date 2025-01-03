WITH base AS (
  SELECT
    JSON_QUERY(data, '$') AS json_data
  FROM {{ source('humanresources', 'humanresources_shift') }}
)

SELECT
  SAFE_CAST(JSON_VALUE(json_data, '$.shiftid') AS INT64) AS shift_id,
  JSON_VALUE(json_data, '$.name') AS shift_name,
  SAFE_CAST(JSON_VALUE(json_data, '$.starttime') AS TIME) AS start_time,
  SAFE_CAST(JSON_VALUE(json_data, '$.endtime') AS TIME) AS end_time,
  SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
