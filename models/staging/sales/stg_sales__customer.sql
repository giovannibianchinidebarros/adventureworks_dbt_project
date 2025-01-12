WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_customer') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.customerid') AS INT64) AS pk_customer_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.personid') AS INT64) AS fk_person_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.storeid') AS INT64) AS fk_store_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.territoryid') AS INT64) AS territory_id,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
