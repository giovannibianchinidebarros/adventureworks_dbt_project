WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_creditcard') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.creditcardid') AS INT64) AS credit_card_id,
    JSON_VALUE(json_data, '$.cardtype') AS card_type,
    JSON_VALUE(json_data, '$.cardnumber') AS card_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.expmonth') AS INT64) AS exp_month,
    SAFE_CAST(JSON_VALUE(json_data, '$.expyear') AS INT64) AS exp_year,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
