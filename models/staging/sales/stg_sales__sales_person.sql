WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesperson') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS pk_salesperson_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.territoryid') AS INT64) AS fk_territory_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.salesquota') AS FLOAT64) AS sales_quota,
    SAFE_CAST(JSON_VALUE(json_data, '$.bonus') AS FLOAT64) AS bonus,
    SAFE_CAST(JSON_VALUE(json_data, '$.commissionpct') AS FLOAT64) AS commission_pct,
    SAFE_CAST(JSON_VALUE(json_data, '$.salesytd') AS FLOAT64) AS sales_ytd,
    SAFE_CAST(JSON_VALUE(json_data, '$.saleslastyear') AS FLOAT64) AS sales_last_year,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
