-- Создание представления со столбцами номера
-- покупателя и суммарной стоимости всех его попкупок

CREATE OR REPLACE VIEW customer_summary AS
SELECT Cu.customer_id AS Customer,
SUM(Pr.price) AS customer_summary
FROM
Customers Cu, Purchases Pu,
Purchases_products Ppr, Products Pr
WHERE
(Cu.customer_id=Pu.customer_id) AND
(Pu.purchase_id=Ppr.purchase_id) AND
(Ppr.product_id=Pr.product_id) 
GROUP BY (Cu.customer_id);