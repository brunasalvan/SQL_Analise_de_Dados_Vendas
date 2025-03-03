/* Which category sells the most across Brazil? */
/* Qual categoria mais vende no Brasil inteiro? */

SELECT TOP 1 PRODUCT_CATEGORY_NAME AS DEPARTAMENTO, COUNT(PRODUCT_CATEGORY_NAME) AS VENDAS
FROM Tb_ACT_OLIST_ORDER_ITEMS OI
	INNER JOIN Tb_ACT_OLIST_PRODUCTS P
	ON OI.PRODUCT_ID = P.PRODUCT_ID
GROUP BY PRODUCT_CATEGORY_NAME
ORDER BY COUNT(PRODUCT_CATEGORY_NAME) DESC, PRODUCT_CATEGORY_NAME;

--> cama_mesa_banho = 11115


/* Best-selling products in each region of the country */
/* Produtos mais vendidos em cada região do país */

SELECT S.SELLER_STATE AS ESTADO, P.PRODUCT_CATEGORY_NAME AS DEPARTAMENTO, COUNT(P.PRODUCT_CATEGORY_NAME) AS VENDAS
FROM Tb_ACT_OLIST_PRODUCTS AS P
	INNER JOIN Tb_ACT_OLIST_ORDER_ITEMS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
	INNER JOIN Tb_ACT_OLIST_SELLERS S
	ON OI.SELLER_ID = S.SELLER_ID
GROUP BY P.PRODUCT_CATEGORY_NAME, S.SELLER_STATE
ORDER BY SELLER_STATE, COUNT(PRODUCT_CATEGORY_NAME) DESC;


/* Best-selling products in the state of SC */
/* Produtos mais vendidos no estado de SC */

SELECT TOP 1 S.SELLER_STATE AS ESTADO, P.PRODUCT_CATEGORY_NAME AS DEPARTAMENTO, COUNT(P.PRODUCT_CATEGORY_NAME) AS VENDAS
FROM Tb_ACT_OLIST_PRODUCTS AS P
	INNER JOIN Tb_ACT_OLIST_ORDER_ITEMS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
	INNER JOIN Tb_ACT_OLIST_SELLERS S
	ON OI.SELLER_ID = S.SELLER_ID
WHERE SELLER_STATE = 'SC'
GROUP BY P.PRODUCT_CATEGORY_NAME, S.SELLER_STATE
ORDER BY SELLER_STATE, COUNT(PRODUCT_CATEGORY_NAME) DESC;

--> esporte_lazer


/* Which state sells the most? */
/* Qual estado que mais vende? */

SELECT TOP 1 SELLER_STATE AS ESTADO, COUNT(SELLER_STATE) AS TOTAL_VENDAS
FROM Tb_ACT_OLIST_SELLERS
GROUP BY SELLER_STATE
ORDER BY TOTAL_VENDAS DESC;

--> SP = 1849 vendas


/* Which state sells the least? */
/* Qual estado que menos vende? */

SELECT TOP 1 SELLER_STATE AS ESTADO, COUNT(SELLER_STATE) AS TOTAL_VENDAS
FROM Tb_ACT_OLIST_SELLERS
GROUP BY SELLER_STATE
ORDER BY TOTAL_VENDAS;

--> PA = 1 venda


/* Which state buys the most? */
/* Qual estado que mais compra? */

SELECT TOP 1 CUSTOMER_STATE AS ESTADO, COUNT(CUSTOMER_STATE) AS TOTAL_COMPRAS
FROM Tb_ACT_OLIST_CUSTOMER
GROUP BY CUSTOMER_STATE
ORDER BY TOTAL_COMPRAS DESC;

--> SP = 41746 compras


/* Which state buys the least? */
/* Qual estado que menos compra? */

SELECT TOP 1 CUSTOMER_STATE AS ESTADO, COUNT(CUSTOMER_STATE) AS TOTAL_COMPRAS
FROM Tb_ACT_OLIST_CUSTOMER
GROUP BY CUSTOMER_STATE
ORDER BY TOTAL_COMPRAS DESC;

--> RR = 46 compras


/* TOP 10 cities with the highest sales */
/* TOP 10 cidades que mais vendem */

SELECT TOP 10 SELLER_CITY, SELLER_STATE, COUNT(SELLER_STATE) AS TOTAL_VENDAS
FROM Tb_ACT_OLIST_SELLERS
GROUP BY SELLER_STATE, SELLER_CITY
ORDER BY TOTAL_VENDAS DESC;

--> São Paulo, Curitiba, Rio de Janeiro, Belo Horizonte, Ribeirão Preto, Guarulhos, Ibitinga, Santo André, Campinas e Maringá.


/* TOP 10 cities with the highest purchases */
/* TOP 10 cidades que mais compram */

SELECT TOP 10 CUSTOMER_CITY, CUSTOMER_STATE, COUNT(CUSTOMER_STATE) AS TOTAL_COMPRAS
FROM Tb_ACT_OLIST_CUSTOMER
GROUP BY CUSTOMER_STATE, CUSTOMER_CITY
ORDER BY TOTAL_COMPRAS DESC;

--> São Paulo, Rio de Janeiro, Belo Horizonte, Brasília, Curitiba, Campinas, Porto Alegre, Salvador, Guarulhos e São Bernardo do Campo


/* Average order value */
/* Valor médio por pedido */

SELECT ROUND(AVG(PAYMENT_VALUE) * 1, 2) AS MEDIA_VALOR_PEDIDO
FROM Tb_ACT_OLIST_ORDER_PAYMENTS;

R$ 154,00


/* Orders placed per year */
/* Pedidos realizados por ano */

SELECT YEAR(ORDER_PURCHASE_TIMESTAMP) AS ANO, COUNT(*) AS VENDAS
FROM Tb_ACT_OLIST_ORDERS
GROUP BY YEAR(ORDER_PURCHASE_TIMESTAMP)
ORDER BY YEAR(ORDER_PURCHASE_TIMESTAMP);

--> Uma crescente constante nas vendas 


/* Months with the best sales performance */
/* Meses de melhor desempenho nas vendas */

SELECT MONTH(ORDER_PURCHASE_TIMESTAMP) AS MES, COUNT(*) AS VENDAS
FROM Tb_ACT_OLIST_ORDERS
GROUP BY MONTH(ORDER_PURCHASE_TIMESTAMP)
ORDER BY COUNT(ORDER_PURCHASE_TIMESTAMP) DESC;

--> Agosto, Maio e Julho


/* Months with the worst sales performance */
/* Meses de pior desempenho nas vendas */

SELECT MONTH(ORDER_PURCHASE_TIMESTAMP) AS MES, COUNT(*) AS VENDAS
FROM Tb_ACT_OLIST_ORDERS
GROUP BY MONTH(ORDER_PURCHASE_TIMESTAMP)
ORDER BY COUNT(ORDER_PURCHASE_TIMESTAMP);

--> Setembro, Outubro, Dezembro


/* Days of the month with the most orders placed */
/* Dias do mês que mais são efetuados pedidos */

SELECT DAY(ORDER_PURCHASE_TIMESTAMP) AS DIA, COUNT(*) AS VENDAS
FROM Tb_ACT_OLIST_ORDERS
GROUP BY DAY(ORDER_PURCHASE_TIMESTAMP)
ORDER BY COUNT(ORDER_PURCHASE_TIMESTAMP) DESC;

--> 24, 16, 15, 4, 6


/* List orders delivered on time and late */
/* Listar pedidos entregues dentro e fora do prazo de entrega */

SELECT ORDER_ID AS PEDIDO, ORDER_ESTIMATED_DELIVERY_DATE AS PRAZO_ENTREGA, ORDER_DELIVERED_CUSTOMER_DATE AS DATA_ENTREGA,
CASE
	WHEN ORDER_ESTIMATED_DELIVERY_DATE >= ORDER_DELIVERED_CUSTOMER_DATE THEN 'Dentro do Prazo'
	WHEN ORDER_ESTIMATED_DELIVERY_DATE < ORDER_DELIVERED_CUSTOMER_DATE THEN 'Fora do Prazo'
END AS PRAZO
FROM Tb_ACT_OLIST_ORDERS;


/* List only orders delivered late */
/* Listar apenas pedidos entregues fora do prazo de entrega */

SELECT ORDER_ID AS PEDIDO, ORDER_ESTIMATED_DELIVERY_DATE AS PRAZO_ENTREGA, ORDER_DELIVERED_CUSTOMER_DATE AS DATA_ENTREGA
FROM Tb_ACT_OLIST_ORDERS
WHERE ORDER_ESTIMATED_DELIVERY_DATE < ORDER_DELIVERED_CUSTOMER_DATE;


/* Revenue for all months of 2017 */
/* Receita de todos os meses de 2017 */

SELECT YEAR(O.ORDER_PURCHASE_TIMESTAMP) AS ANO, MONTH(O.ORDER_PURCHASE_TIMESTAMP) AS MÊS, SUM(OI.PRICE) AS RECEITA
FROM Tb_ACT_OLIST_ORDERS O
	INNER JOIN Tb_ACT_OLIST_ORDER_ITEMS OI
	ON O.ORDER_ID = OI.ORDER_ID
WHERE YEAR(O.ORDER_PURCHASE_TIMESTAMP) = '2017'
GROUP BY YEAR(O.ORDER_PURCHASE_TIMESTAMP), MONTH(O.ORDER_PURCHASE_TIMESTAMP)
ORDER BY MONTH(O.ORDER_PURCHASE_TIMESTAMP);


/* Total revenue in October 2017 */
/* Receita total no mês de outubro de 2017 */

SELECT YEAR(O.ORDER_PURCHASE_TIMESTAMP) AS ANO, MONTH(O.ORDER_PURCHASE_TIMESTAMP) AS MÊS, SUM(OI.PRICE) AS RECEITA
FROM Tb_ACT_OLIST_ORDERS O
	INNER JOIN Tb_ACT_OLIST_ORDER_ITEMS OI
	ON O.ORDER_ID = OI.ORDER_ID
WHERE YEAR(O.ORDER_PURCHASE_TIMESTAMP) = '2017'AND MONTH(O.ORDER_PURCHASE_TIMESTAMP) = '10'
GROUP BY YEAR(O.ORDER_PURCHASE_TIMESTAMP), MONTH(O.ORDER_PURCHASE_TIMESTAMP)
ORDER BY SUM(OI.PRICE) DESC;
