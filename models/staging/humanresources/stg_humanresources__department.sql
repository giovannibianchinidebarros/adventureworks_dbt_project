WITH base AS (
  SELECT
    JSON_QUERY(data, '$') AS json_data
    from {{ source('humanresources','humanresources_department') }}
)
SELECT
  JSON_VALUE(json_data, '$.departmentid') AS department_id,
  JSON_VALUE(json_data, '$.name') AS name,
  JSON_VALUE(json_data, '$.groupname') AS group_name,
  JSON_VALUE(json_data, '$.modifieddate') AS modified_date
FROM base