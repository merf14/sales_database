-- Функция, выводящая для пользователей 
--с номерами в заданном интервале минимальное количество дней, 
--прошедшее между регистрацией пользователя и его первой покупкой.

CREATE OR REPLACE FUNCTION min_day (begin INT, end INT)
RETURNS INTEGER AS
$$
    DECLARE
        rec RECORD;
        m INTEGER := 120;
        curs1 CURSOR FOR
        SELECT Cu.reg_date as reg, min(Pu.purchase_date) as purch
        FROM Customers Cu, Purchases Pu
        WHERE Cu.customer_id BETWEEN begin and end
        AND (Cu.customer_id=Pu.customer_id)
        GROUP BY Cu.reg_date;
    BEGIN
        FOR rec IN curs1 LOOP
            IF (rec.purch-rec.reg)>0 AND (rec.purch-rec.reg)<m THEN
                m:=(rec.purch-rec.reg);
            END IF;
        END LOOP;
        RETURN m;
    END;
$$
LANGUAGE plpgsql