WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_workorder') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.workorderid') AS INT64) AS pk_work_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.orderqty') AS INT64) AS order_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.scrappedqty') AS INT64) AS scrapped_qty,
    SAFE_CAST(JSON_VALUE(json_data, '$.startdate') AS DATETIME) AS start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.enddate') AS DATETIME) AS end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.duedate') AS DATETIME) AS due_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.scrapreasonid') AS INT64) AS fk_scrap_reason_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
