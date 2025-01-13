WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_illustration') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.illustrationid') AS INT64) AS pk_illustration_id,
    JSON_VALUE(json_data, '$.diagram') AS diagram,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
