WITH 
customer AS (
    SELECT * 
    FROM {{ ref("stg_sales__customer") }}
)
, final AS (
    SELECT
        customer.pk_customer_id
        , customer.fk_person_id
        , customer.fk_store_id
        , customer.fk_territory_id
    FROM customer
)
SELECT * FROM final