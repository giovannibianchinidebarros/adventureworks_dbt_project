WITH base AS (
  SELECT
    JSON_QUERY(data, '$') AS json_data
  FROM {{ source('person', 'person_businessentitycontact') }}
)

SELECT
  SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS fk_business_entity_id,
  SAFE_CAST(JSON_VALUE(json_data, '$.personid') AS INT64) AS person_id,
  SAFE_CAST(JSON_VALUE(json_data, '$.contacttypeid') AS INT64) AS contact_type_id,
  JSON_VALUE(json_data, '$.rowguid') AS row_guid,
  SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
