WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('person', 'person_address') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.addressid') AS INT64) AS address_id,
    JSON_VALUE(json_data, '$.addressline1') AS address_line1,
    JSON_VALUE(json_data, '$.addressline2') AS address_line2,
    JSON_VALUE(json_data, '$.city') AS city,
    SAFE_CAST(JSON_VALUE(json_data, '$.stateprovinceid') AS INT64) AS state_province_id,
    JSON_VALUE(json_data, '$.postalcode') AS postal_code,
    JSON_VALUE(json_data, '$.spatiallocation') AS spatial_location,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
