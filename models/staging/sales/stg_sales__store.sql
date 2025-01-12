WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_store') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    JSON_VALUE(json_data, '$.name') AS store_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.salespersonid') AS INT64) AS sales_person_id,
    JSON_VALUE(json_data, '$.demographics') AS demographics,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
