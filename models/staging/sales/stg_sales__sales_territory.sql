WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('sales', 'sales_salesterritory') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.territoryid') AS INT64) AS territory_id,
    JSON_VALUE(json_data, '$.name') AS territory_name,
    JSON_VALUE(json_data, '$.countryregioncode') AS country_region_code,
    JSON_VALUE(json_data, '$.group') AS territory_group,
    SAFE_CAST(JSON_VALUE(json_data, '$.salesytd') AS FLOAT64) AS sales_ytd,
    SAFE_CAST(JSON_VALUE(json_data, '$.saleslastyear') AS FLOAT64) AS sales_last_year,
    SAFE_CAST(JSON_VALUE(json_data, '$.costytd') AS FLOAT64) AS cost_ytd,
    SAFE_CAST(JSON_VALUE(json_data, '$.costlastyear') AS FLOAT64) AS cost_last_year,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
