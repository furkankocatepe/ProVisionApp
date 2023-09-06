USE Retail;
GO

DROP VIEW IF EXISTS View_SpecialDays;
GO

CREATE VIEW View_SpecialDays AS
(
SELECT *, 
	CASE 
	WHEN MONTH(date) = 2 AND DAY(date) = 14 THEN 1							/* VALENTINES DAY */
	WHEN MONTH(date) = 3 AND DAY(date) = 8	THEN 1							/* WOMENS DAY */
	WHEN MONTH(date) = 4 AND DAY(date) = 23 THEN 1							/* NATIONAL DAY */
	WHEN MONTH(date) = 8 AND DAY(date) = 30 THEN 1							/* NATIONAL DAY */
	WHEN MONTH(date) = 10 AND DAY(date) = 29 THEN 1							/* NATIONAL DAY */
	WHEN MONTH(date) = 5 AND DAY(date) = 19 THEN 1							/* NATIONAL DAY */
	WHEN MONTH(date) = 5 AND DAY(date) = 1 THEN 1							/* LABOUR DAY */
	WHEN MONTH(date) = 7 AND DAY(date) = 15 THEN 1							/* NATIONAL DAY */
	WHEN MONTH(date) = 11 AND DAY(date) = 24 THEN 1							/* TEACHERS DAY */
	WHEN MONTH(date) = 12 AND DAY(date) = 31 THEN 1							/* NEW YEARS */
	WHEN MONTH(date) = 1 AND DAY(date) = 1 THEN 1							/* NEW YEARS */
	WHEN MONTH(date) = 11 AND DAY(date) BETWEEN 20 AND 27 THEN 1			/* BLACK FRIDAY */
	WHEN MONTH(date) = 5 AND DAY(date) BETWEEN 10 AND 17 THEN 1				/* MOTHERS DAY */
	WHEN MONTH(date) = 6 AND DAY(date) BETWEEN 14 AND 21 THEN 1				/* FATHERS DAY */
	WHEN YEAR(date) = 2017 AND MONTH(date) = 6 
	AND DAY(date) BETWEEN 10 AND 24 THEN 1									/* PRE EID 2017*/
	WHEN YEAR(date) = 2017 AND MONTH(date) = 6 
	AND DAY(date) BETWEEN 25 AND 27 THEN 1									/* EID 2017*/
	WHEN YEAR(date) = 2017 AND MONTH(date) = 8 
	AND DAY(date) BETWEEN 23 AND 30 THEN 1									/* PRE EID 2017*/
	WHEN YEAR(date) = 2017 AND MONTH(date) = 9 
	AND DAY(date) BETWEEN 1 AND 4 THEN 1									/* EID 2017*/
	WHEN YEAR(date) = 2018 AND MONTH(date) = 6 
	AND DAY(date) BETWEEN 1 AND 14 THEN 1									/* PRE EID 2018*/
	WHEN YEAR(date) = 2018 AND MONTH(date) = 6 
	AND DAY(date) BETWEEN 15 AND 17 THEN 1									/* EID 2018*/
	WHEN YEAR(date) = 2018 AND MONTH(date) = 8 
	AND DAY(date) BETWEEN 13 AND 20 THEN 1									/* PRE EID 2018*/
	WHEN YEAR(date) = 2018 AND MONTH(date) = 8 
	AND DAY(date) BETWEEN 21 AND 24 THEN 1									/* EID 2018*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 5 
	AND DAY(date) BETWEEN 21 AND 31 THEN 1									/* PRE EID 2019*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 6 
	AND DAY(date) BETWEEN 1 AND 4 THEN 1									/* PRE EID 2019*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 6 
	AND DAY(date) BETWEEN 5 AND 7 THEN 1									/* EID 2019*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 8 
	AND DAY(date) BETWEEN 3 AND 10 THEN 1									/* PRE EID 2019*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 8 
	AND DAY(date) BETWEEN 11 AND 14 THEN 1									/* EID 2019*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 5 
	AND DAY(date) BETWEEN 8 AND 23 THEN 1									/* PRE EID 2020*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 5 
	AND DAY(date) BETWEEN 24 AND 26 THEN 1									/* EID 2020*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 7 
	AND DAY(date) BETWEEN 12 AND 19 THEN 1									/* PRE EID 2020*/
	WHEN YEAR(date) = 2019 AND MONTH(date) = 7 
	AND DAY(date) BETWEEN 20 AND 23 THEN 1									/* EID 2020*/
	ELSE 0 END
	AS isSpecialDay
FROM SALES);

DROP VIEW IF EXISTS View_Daily_Store;
GO

CREATE VIEW View_Daily_Store AS 
(
SELECT 
    date,
    store_id,
    ROUND(SUM(sales), 0) AS total_sales,  
    SUM(revenue) AS total_revenue,
    ROUND(SUM(stock), 0) AS total_stock,  
    AVG(price) AS average_price, 
	isSpecialDay
FROM 
    View_SpecialDays
GROUP BY 
    date, store_id, isSpecialDay
);

DROP VIEW IF EXISTS View_Weekly_Store;
GO

CREATE VIEW View_Weekly_Store AS
(
SELECT 
    DATEADD(wk, DATEDIFF(wk, 0, date), 0) AS date, 
    store_id,
    ROUND(SUM(sales), 0) AS total_sales,  
    SUM(revenue) AS total_revenue,
    ROUND(SUM(stock), 0) AS total_stock,  
    AVG(price) AS average_price  
FROM 
    sales
GROUP BY 
    DATEADD(wk, DATEDIFF(wk, 0, date), 0), store_id
);

DROP VIEW IF EXISTS WEEKLY_CITY;
GO

CREATE VIEW WEEKLY_CITY AS
(
SELECT date, S.store_id, city_id, total_sales, total_revenue, total_stock, average_price
FROM View_Weekly_Store AS V join STORE AS S 
		ON V.store_id = S.store_id
WHERE total_sales IS NOT NULL
AND total_revenue IS NOT NULL
AND total_stock IS NOT NULL
);

DROP VIEW IF EXISTS DAILY_CITY;
GO

CREATE VIEW DAILY_CITY AS
(
SELECT date, S.store_id, city_id, total_sales, total_revenue, total_stock, average_price, isSpecialDay
FROM View_Daily_Store AS V join STORE AS S 
		ON V.store_id = S.store_id
WHERE total_sales IS NOT NULL
AND total_revenue IS NOT NULL
AND total_stock IS NOT NULL
)

DROP VIEW IF EXISTS WEEKLY_PRODUCT;
GO
