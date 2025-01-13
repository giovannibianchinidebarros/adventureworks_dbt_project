WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_location') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.locationid') AS INT64) AS pk_location_id,
    JSON_VALUE(json_data, '$.name') AS location_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.costrate') AS FLOAT64) AS cost_rate,
    SAFE_CAST(JSON_VALUE(json_data, '$.availability') AS FLOAT64) AS availability,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
