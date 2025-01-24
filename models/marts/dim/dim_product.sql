WITH 
product AS (
    SELECT * 
    FROM {{ ref("stg_production__product") }}
)
, subcategory AS (
    SELECT * 
    FROM {{ ref("int_product_subcategory") }}
)
, size_unit AS (
    SELECT * 
    FROM {{ ref("stg_production__unit_measure") }}
)
, weight_unit AS (
    SELECT * 
    FROM {{ ref("stg_production__unit_measure") }}
)
, model AS (
    SELECT * 
    FROM {{ ref("int_product_model_description") }}
)
, final AS (
    SELECT
        product.pk_product_id AS product_id
        , product.product_name
        , product.product_number
        , product.make_flag
        , product.finished_goods_flag
        , product.color
        , product.safety_stock_level
        , product.reorder_point
        , product.standard_cost
        , product.list_price
        , product.size
        , size_unit.pk_unit_measure_code AS size_code
        , product.weight
        , weight_unit.pk_unit_measure_code AS weight_code
        , product.product_line
        , product.class
        , product.style
        , subcategory.subcategory_name AS subcategory
        , subcategory.category_name AS category
        , model.product_model_name AS model_name
        , model.description AS model_description
        , sell_start_date
        , sell_end_date
        , discontinued_date
    FROM product
    LEFT JOIN subcategory 
        ON product.fk_product_subcategory_id = subcategory.product_subcategory_id
    LEFT JOIN size_unit 
        ON product.fk_size_unit_measure_code = size_unit.pk_unit_measure_code
    LEFT JOIN weight_unit 
        ON product.fk_weight_unit_measure_code = weight_unit.pk_unit_measure_code
    LEFT JOIN model 
        ON product.product_model_id = model.product_model_id
)
SELECT * FROM final