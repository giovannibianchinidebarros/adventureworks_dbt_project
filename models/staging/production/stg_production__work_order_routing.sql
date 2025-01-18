WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_workorderrouting') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.workorderid') AS INT64) AS fk_work_order_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS fk_product_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.operationsequence') AS INT64) AS operation_sequence,
    SAFE_CAST(JSON_VALUE(json_data, '$.locationid') AS INT64) AS fk_location_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.scheduledstartdate') AS DATETIME) AS scheduled_start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.scheduledenddate') AS DATETIME) AS scheduled_end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.actualstartdate') AS DATETIME) AS actual_start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.actualenddate') AS DATETIME) AS actual_end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.actualresourcehrs') AS FLOAT64) AS actual_resource_hrs,
    SAFE_CAST(JSON_VALUE(json_data, '$.plannedcost') AS FLOAT64) AS planned_cost,
    SAFE_CAST(JSON_VALUE(json_data, '$.actualcost') AS FLOAT64) AS actual_cost,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
