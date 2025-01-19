WITH 
customer AS (
    SELECT * 
    FROM {{ ref("stg_sales__customer") }}
)
, person AS (
    SELECT * 
    FROM {{ ref("int_person") }}
)
, store AS (
    SELECT * 
    FROM {{ ref("stg_sales__store") }}
)
, final AS (
    SELECT
        customer.pk_customer_id
        , customer.fk_person_id
        , person.person_name
        , customer.fk_store_id
        , store.store_name
        , customer.fk_territory_id
        -- Nova coluna customer_type com prioridade para store
        , CASE 
            WHEN store.store_name IS NOT NULL THEN 'store'
            WHEN person.person_name IS NOT NULL THEN 'person'
            ELSE 'unknown'
        END AS customer_type
        -- Nova coluna customer_name com prioridade para store_name
        , CASE
            WHEN store.store_name IS NOT NULL THEN store.store_name
            WHEN person.person_name IS NOT NULL THEN person.person_name
            ELSE 'Unknown'
        END AS customer_name
    FROM customer
    LEFT JOIN person 
        ON customer.fk_person_id = person.person_id
    LEFT JOIN store 
        ON customer.fk_store_id = store.pk_store_id
)
SELECT * FROM final
