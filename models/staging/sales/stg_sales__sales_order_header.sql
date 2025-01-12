WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesorderheader') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.salesorderid') AS INT64) AS sales_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.revisionnumber') AS INT64) AS revision_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.orderdate') AS DATETIME) AS order_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.duedate') AS DATETIME) AS due_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.shipdate') AS DATETIME) AS ship_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.status') AS INT64) AS status,
    SAFE_CAST(JSON_VALUE(json_data, '$.onlineorderflag') AS BOOLEAN) AS online_order_flag,
    JSON_VALUE(json_data, '$.purchaseordernumber') AS purchase_order_number,
    JSON_VALUE(json_data, '$.accountnumber') AS account_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.customerid') AS INT64) AS customer_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.salespersonid') AS INT64) AS salesperson_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.territoryid') AS INT64) AS territory_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.billtoaddressid') AS INT64) AS bill_to_address_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.shiptoaddressid') AS INT64) AS ship_to_address_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.shipmethodid') AS INT64) AS ship_method_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.creditcardid') AS INT64) AS credit_card_id,
    JSON_VALUE(json_data, '$.creditcardapprovalcode') AS credit_card_approval_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.currencyrateid') AS INT64) AS currency_rate_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.subtotal') AS FLOAT64) AS subtotal,
    SAFE_CAST(JSON_VALUE(json_data, '$.taxamt') AS FLOAT64) AS tax_amount,
    SAFE_CAST(JSON_VALUE(json_data, '$.freight') AS FLOAT64) AS freight,
    SAFE_CAST(JSON_VALUE(json_data, '$.totaldue') AS FLOAT64) AS total_due,
    JSON_VALUE(json_data, '$.comment') AS comment,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
