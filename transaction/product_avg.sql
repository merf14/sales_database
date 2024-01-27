--Функция, возвращающая среднюю цену товара.

CREATE OR REPLACE FUNCTION product_avg (product text)
RETURNS INTEGER AS
$$
    DECLARE
        price INTEGER;
        s INT :=0;
        k INT :=0;
    BEGIN
    FOR price IN
    (SELECT Pr.price
    FROM Products Pr
    WHERE Pr.name=product)
    LOOP
        k:=k+1;
        s:=s+price;
    END LOOP;
    RETURN s/k;
    EXCEPTION WHEN division_by_zero THEN
        RAISE NOTICE 'There is no such product in DB';
    END;
$$
LANGUAGE plpgsql