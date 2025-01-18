WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_countryregion') }}
)

SELECT
    JSON_VALUE(json_data, '$.countryregioncode') AS pk_country_region_code,
    JSON_VALUE(json_data, '$.name') AS country_region_name,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
