WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('purchasing', 'purchasing_shipmethod') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.shipmethodid') AS INT64) AS ship_method_id,
    JSON_VALUE(json_data, '$.name') AS name,
    SAFE_CAST(JSON_VALUE(json_data, '$.shipbase') AS FLOAT64) AS ship_base,
    SAFE_CAST(JSON_VALUE(json_data, '$.shiprate') AS FLOAT64) AS ship_rate,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
