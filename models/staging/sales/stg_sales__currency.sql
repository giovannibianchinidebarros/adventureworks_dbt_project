WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_currency') }}
)

SELECT
    JSON_VALUE(json_data, '$.currencycode') AS pk_currency_code,
    JSON_VALUE(json_data, '$.name') AS name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
