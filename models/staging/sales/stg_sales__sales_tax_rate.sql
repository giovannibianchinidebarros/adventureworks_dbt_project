WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salestaxrate') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.salestaxrateid') AS INT64) AS sales_tax_rate_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.stateprovinceid') AS INT64) AS state_province_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.taxtype') AS INT64) AS tax_type,
    SAFE_CAST(JSON_VALUE(json_data, '$.taxrate') AS FLOAT64) AS tax_rate,
    JSON_VALUE(json_data, '$.name') AS tax_rate_name,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
