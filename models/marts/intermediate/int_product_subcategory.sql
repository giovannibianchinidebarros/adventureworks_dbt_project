WITH 
subcategory AS (
    SELECT * 
    FROM {{ ref("stg_production__product_subcategory") }}
)
, category AS (
    SELECT * 
    FROM {{ ref("stg_production__product_category") }}
)
, final AS (
    SELECT
        subcategory.pk_product_subcategory_id as product_subcategory_id
        , subcategory.subcategory_name
        , category.category_name
    FROM subcategory
    LEFT JOIN category 
        ON subcategory.fk_product_category_id = category.pk_product_category_id
)
SELECT * FROM final