WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('humanresources','humanresources_employee') }}
)
SELECT
  SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
  JSON_VALUE(json_data, '$.nationalidnumber') AS national_id_number,
  JSON_VALUE(json_data, '$.loginid') AS login_id,
  JSON_VALUE(json_data, '$.jobtitle') AS job_title,
  SAFE_CAST(JSON_VALUE(json_data, '$.birthdate') AS DATE) AS birth_date,
  JSON_VALUE(json_data, '$.maritalstatus') AS marital_status,
  JSON_VALUE(json_data, '$.gender') AS gender,
  SAFE_CAST(JSON_VALUE(json_data, '$.hiredate') AS DATE) AS hired_date,
  SAFE_CAST(JSON_VALUE(json_data, '$.salariedflag') AS BOOL) AS salaried_flag,
  SAFE_CAST(JSON_VALUE(json_data, '$.vacationhours') AS INT64) AS vacation_hours,
  SAFE_CAST(JSON_VALUE(json_data, '$.sickleavehours') AS INT64) AS sick_leave_hours,
  SAFE_CAST(JSON_VALUE(json_data, '$.currentflag') AS BOOL) AS current_flag,
  JSON_VALUE(json_data, '$.rowguid') AS row_guid,
  SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date,
  JSON_VALUE(json_data, '$.organizationnode') AS organization_node
FROM base
