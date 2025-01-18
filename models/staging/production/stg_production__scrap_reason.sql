WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_scrapreason') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.scrapreasonid') AS INT64) AS pk_scrap_reason_id,
    JSON_VALUE(json_data, '$.name') AS scrap_reason_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
