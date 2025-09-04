******************************************************************
***** Consultas para equipe de Maketing e Comercial **************
******************************************************************
*** PL/SQL**
******************************************************************
  
**Listar todos Clientes que não tenham realizado uma compra;
SELECT
    c.*
FROM
    customer c
LEFT JOIN
    orders o ON c.customer_id = o.customer_id
LEFT JOIN
    store s ON o.store_id = s.store_id
WHERE
    o.order_id IS NULL;

******************************************************************
******************************************************************
**Listar os Produtos que não tenham sido comprados

SELECT p.product_id, p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM sales s
    WHERE s.product_id = p.product_id
)
AND p.stock_id IS NOT NULL 	
AND p.store_id IS NOT NULL;

******************************************************************
******************************************************************
**Listar os Produtos sem Estoque:

SELECT
    t1.product_id,
    t1.product_name,
    t2.quantity     
FROM
    products AS t1, stocks AS t2
INNER JOIN
    stocks AS t2 ON t1.product_id = t2.product_id 
AND
    t2.quantity = 0;
******************************************************************
******************************************************************
**Agrupar a quantidade de vendas que uma determinada Marca por Loja.

SELECT
    b.brand_name,
    COUNT(o.order_id) AS quantidade_vendas
FROM
    orders o
JOIN
    stores s ON o.store_id = s.store_id
JOIN
    order_item i ON s.order_id = i.order_id
JOIN
    products p ON i.product_id = p.product_id
JOIN
    brands b ON p.brand_id = b.brand_id
GROUP BY
    b.brand_name
ORDER BY
    quantidade_vendas DESC;

******************************************************************
******************************************************************
**Listar os Funcionarios que não estejam relacionados a um Pedido.

SELECT s.first_name
FROM staffs s
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.staff_id = s.staff_id
);






