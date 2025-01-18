WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_productcosthistory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.startdate') AS DATETIME) AS start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.enddate') AS DATETIME) AS end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.standardcost') AS FLOAT64) AS standard_cost,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
