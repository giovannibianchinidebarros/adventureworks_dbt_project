WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('purchasing', 'purchasing_purchaseorderheader') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.purchaseorderid') AS INT64) AS pk_purchase_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.revisionnumber') AS INT64) AS revision_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.status') AS INT64) AS status,
    SAFE_CAST(JSON_VALUE(json_data, '$.employeeid') AS INT64) AS fk_employee_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.vendorid') AS INT64) AS fk_vendor_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.shipmethodid') AS INT64) AS fk_ship_method_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.orderdate') AS DATETIME) AS order_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.shipdate') AS DATETIME) AS ship_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.subtotal') AS FLOAT64) AS sub_total,
    SAFE_CAST(JSON_VALUE(json_data, '$.taxamt') AS FLOAT64) AS tax_amount,
    SAFE_CAST(JSON_VALUE(json_data, '$.freight') AS FLOAT64) AS freight,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
