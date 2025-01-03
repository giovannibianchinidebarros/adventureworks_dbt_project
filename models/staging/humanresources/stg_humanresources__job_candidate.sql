WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('humanresources', 'humanresources_jobcandidate') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.jobcandidateid') AS INT64) AS job_candidate_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.businessentityid') AS INT64) AS business_entity_id,
    JSON_VALUE(json_data, '$.resume') AS resume,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
