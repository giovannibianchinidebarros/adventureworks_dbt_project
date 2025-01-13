WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesterritoryhistory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS fk_salesperson_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.territoryid') AS INT64) AS fk_territory_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.startdate') AS DATETIME) AS start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.enddate') AS DATETIME) AS end_date,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
