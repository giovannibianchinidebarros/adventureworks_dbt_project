WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_culture') }}
)

SELECT
    JSON_VALUE(json_data, '$.cultureid') AS pk_culture_id,
    JSON_VALUE(json_data, '$.name') AS culture_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
