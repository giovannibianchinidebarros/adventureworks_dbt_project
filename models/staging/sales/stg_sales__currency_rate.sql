WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_currencyrate') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.currencyrateid') AS INT64) AS pk_currency_rate_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.currencyratedate') AS DATETIME) AS currency_rate_date,
    JSON_VALUE(json_data, '$.fromcurrencycode') AS fk_from_currency_code,
    JSON_VALUE(json_data, '$.tocurrencycode') AS fk_to_currency_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.averagerate') AS FLOAT64) AS average_rate,
    SAFE_CAST(JSON_VALUE(json_data, '$.endofdayrate') AS FLOAT64) AS end_of_day_rate,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
