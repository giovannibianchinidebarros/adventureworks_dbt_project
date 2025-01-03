WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('humanresources', 'humanresources_employeepayhistory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.ratechangedate') AS DATETIME) AS rate_change_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.rate') AS FLOAT64) AS rate,
    SAFE_CAST(JSON_VALUE(json_data, '$.payfrequency') AS INT64) AS pay_frequency,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
