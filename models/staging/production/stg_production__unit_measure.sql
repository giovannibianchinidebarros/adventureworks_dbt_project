WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_unitmeasure') }}
)

SELECT
    JSON_VALUE(json_data, '$.unitmeasurecode') AS pk_unit_measure_code,
    JSON_VALUE(json_data, '$.name') AS unit_measure_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
