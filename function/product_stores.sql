-- Функция, выводящая для товара список магазинов, в которых он в наличии.

CREATE OR REPLACE FUNCTION product_stores (product text)
RETURNS INTEGER[] AS
$$
    DECLARE
        stores INTEGER[];
        x INTEGER;
    BEGIN
    FOR x IN
    (SELECT UNNEST(store_ids)
    FROM Products Pr
    WHERE Pr.name=product)
    LOOP
        IF (array_position(stores,x)) IS NULL THEN
            stores=array_append(stores,x);
        ELSE
            CONTINUE;
        END IF;
    END LOOP;
    RETURN stores;
    END;
$$
LANGUAGE plpgsql