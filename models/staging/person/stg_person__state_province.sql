WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_stateprovince') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.stateprovinceid') AS INT64) AS pk_state_province_id,
    JSON_VALUE(json_data, '$.stateprovincecode') AS state_province_code,
    JSON_VALUE(json_data, '$.countryregioncode') AS fk_country_region_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.isonlystateprovinceflag') AS BOOL) AS is_only_state_province_flag,
    JSON_VALUE(json_data, '$.name') AS state_province_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.territoryid') AS INT64) AS fk_territory_id,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
