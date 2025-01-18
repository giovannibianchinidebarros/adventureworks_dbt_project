WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_specialoffer') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.specialofferid') AS INT64) AS pk_special_offer_id,
    JSON_VALUE(json_data, '$.description') AS discount_description,
    SAFE_CAST(JSON_VALUE(json_data, '$.discountpct') AS FLOAT64) AS discount_pct,
    JSON_VALUE(json_data, '$.type') AS discount_type,
    JSON_VALUE(json_data, '$.category') AS discount_group,
    SAFE_CAST(JSON_VALUE(json_data, '$.startdate') AS DATETIME) AS start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.enddate') AS DATETIME) AS end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.minqty') AS INT64) AS min_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.maxqty') AS INT64) AS max_qty,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
