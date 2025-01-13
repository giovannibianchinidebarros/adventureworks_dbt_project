WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_shoppingcartitem') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.shoppingcartitemid') AS INT64) AS pk_shopping_cart_item_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.shoppingcartid') AS INT64) AS shopping_cart_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.quantity') AS INT64) AS quantity,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.datecreated') AS DATETIME) AS date_created,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
