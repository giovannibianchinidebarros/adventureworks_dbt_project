WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_countryregioncurrency') }}
)

SELECT
    JSON_VALUE(json_data, '$.countryregioncode') AS fk_country_region_code,
    JSON_VALUE(json_data, '$.currencycode') AS fk_currency_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
