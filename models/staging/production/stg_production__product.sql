WITH base AS (
    SELECT
        JSON_QUERY(data, '$') AS json_data
    FROM {{ source('production', 'production_product') }}
)

SELECT
    SAFE_CAST(JSON_VALUE(json_data, '$.productid') AS INT64) AS product_id,
    JSON_VALUE(json_data, '$.name') AS product_name,
    JSON_VALUE(json_data, '$.productnumber') AS product_number,
    SAFE_CAST(JSON_VALUE(json_data, '$.makeflag') AS BOOL) AS make_flag,
    SAFE_CAST(JSON_VALUE(json_data, '$.finishedgoodsflag') AS BOOL) AS finished_goods_flag,
    JSON_VALUE(json_data, '$.color') AS color,
    SAFE_CAST(JSON_VALUE(json_data, '$.safetystocklevel') AS INT64) AS safety_stock_level,
    SAFE_CAST(JSON_VALUE(json_data, '$.reorderpoint') AS INT64) AS reorder_point,
    SAFE_CAST(JSON_VALUE(json_data, '$.standardcost') AS FLOAT64) AS standard_cost,
    SAFE_CAST(JSON_VALUE(json_data, '$.listprice') AS FLOAT64) AS list_price,
    JSON_VALUE(json_data, '$.size') AS size,
    JSON_VALUE(json_data, '$.sizeunitmeasurecode') AS size_unit_measure_code,
    JSON_VALUE(json_data, '$.weightunitmeasurecode') AS weight_unit_measure_code,
    SAFE_CAST(JSON_VALUE(json_data, '$.weight') AS FLOAT64) AS weight,
    SAFE_CAST(JSON_VALUE(json_data, '$.daystomanufacture') AS INT64) AS days_to_manufacture,
    JSON_VALUE(json_data, '$.productline') AS product_line,
    JSON_VALUE(json_data, '$.class') AS class,
    JSON_VALUE(json_data, '$.style') AS style,
    SAFE_CAST(JSON_VALUE(json_data, '$.productsubcategoryid') AS INT64) AS product_subcategory_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.productmodelid') AS INT64) AS product_model_id,
    SAFE_CAST(JSON_VALUE(json_data, '$.sellstartdate') AS DATETIME) AS sell_start_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.sellenddate') AS DATETIME) AS sell_end_date,
    SAFE_CAST(JSON_VALUE(json_data, '$.discontinueddate') AS DATETIME) AS discontinued_date,
    JSON_VALUE(json_data, '$.rowguid') AS row_guid,
    SAFE_CAST(JSON_VALUE(json_data, '$.modifieddate') AS DATETIME) AS modified_date
FROM base
