WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesorderdetail') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.salesorderid') AS INT64) AS fk_sales_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.salesorderdetailid') AS INT64) AS pk_sales_order_detail_id,
    JSON_VALUE(json_data, '$.carriertrackingnumber') AS carrier_tracking_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.orderqty') AS INT64) AS order_quantity,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.specialofferid') AS INT64) AS fk_special_offer_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.unitprice') AS FLOAT64) AS unit_price,
    SAFE_CAST(JSON_VALUE(json_data, '$.unitpricediscount') AS FLOAT64) AS unit_price_discount,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
