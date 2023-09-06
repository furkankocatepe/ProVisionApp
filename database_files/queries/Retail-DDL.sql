USE master;
GO

DROP DATABASE IF EXISTS Retail;
GO

CREATE DATABASE Retail;
GO

USE Retail;
GO

CREATE TABLE PRODUCT (
	product_id			VarChar(50)		NOT NULL,
	product_length		float			NULL,
	product_depth		float			NULL,
	produc_width		float			NULL,
	CONSTRAINT			PRODUCT_PK		PRIMARY KEY (product_id)
);

CREATE TABLE PRODUCT_HIERARCHY (
	prod_hierarchy_id	int				NOT NULL IDENTITY (1, 1),
	product_id			VarChar(50)		NOT NULL,
	cluster_id			VarChar(50)		NULL,
	hierarchy1_id		VarChar(50)		NULL,
	hierarchy2_id		VarChar(50)		NULL,
	hierarchy3_id		VarChar(50)		NULL,
	hierarchy4_id		VarChar(50)		NULL,
	hierarchy5_id		VarChar(50)		NULL,
	CONSTRAINT			PROD_HIER_PK	PRIMARY KEY (prod_hierarchy_id),
	CONSTRAINT			PROD_HIER_FK	FOREIGN KEY (product_id)
							REFERENCES	PRODUCT (product_id)
								ON UPDATE CASCADE
								ON DELETE NO ACTION
);


CREATE TABLE STORE (
	store_id			VarChar(50)		NOT NULL, 
	storetype_id		VarChar(50)		NOT NULL, 
	store_size			float			NULL,
	city_id				VarChar(50)		NOT NULL, 
	CONSTRAINT			STORE_PK		PRIMARY KEY (store_id)
);

CREATE TABLE SALES (
	sale_id				int				NOT NULL IDENTITY(1,1),
	product_id			VarChar(50)		NOT NULL,
	store_id			VarChar(50)		NOT NULL, 
	date				Date			NULL,
	sales				float			NULL, 
	revenue				float			NULL, 
	stock				float			NULL,
	price				float			NULL,
	CONSTRAINT			SALES_PK		PRIMARY KEY (sale_id),
	CONSTRAINT			SALES_PROD_FK	FOREIGN KEY (product_id)
							REFERENCES PRODUCT (product_id)
								ON UPDATE CASCADE
								ON DELETE NO ACTION,
	CONSTRAINT			SALES_STORE_FK	FOREIGN KEY (store_id)
							REFERENCES STORE (store_id)
								ON UPDATE CASCADE
								ON DELETE NO ACTION
);

CREATE TABLE PROMO (
	promo_id			int				NOT NULL IDENTITY (1,1),
	sale_id				int				NOT NULL,
	promo_type_1		VarChar(50)		NULL,
	promo_bin_1			VarChar(50)		NULL,
	promo_type_2		VarChar(50)		NULL,
	promo_bin_2			VarChar(50)		NULL,
	promo_discount_2	VarChar(50)		NULL,
	promo_discount_type_2 VarChar(50)	NULL,
	CONSTRAINT			PROMO_PK		PRIMARY KEY (promo_id),
	CONSTRAINT			PROMO_SALES_FK	FOREIGN KEY (sale_id)
							REFERENCES	SALES (sale_id)
								ON UPDATE CASCADE
								ON DELETE NO ACTION
);

CREATE TABLE FT_DAILY_SALES (
	date			Date		NOT NULL,
    store_id		INT			NOT NULL,
    total_stock		FLOAT		NULL,
    average_price	FLOAT		NULL,
    isSpecialDay	INT			NULL,
    dayofweek		INT			NULL,
    quarter			INT			NULL,
    month			INT			NULL,
    year			INT			NULL,
    dayofyear		INT			NULL,
    dayofmonth		INT			NULL,
    weekofyear		INT			NULL,
    total_sales_lag_7 FLOAT		NULL,
    rolling_mean_7	FLOAT		NULL,
    rolling_median_7 FLOAT		NULL,
    rolling_min_7	FLOAT		NULL,
    rolling_max_7	FLOAT		NULL,
    rolling_std_7	FLOAT		NULL
);


CREATE TABLE FT_DAILY_REVENUE (
	date			Date		NOT NULL,
    store_id		INT			NOT NULL,
    total_stock		FLOAT		NULL,
    average_price	FLOAT		NULL,
    isSpecialDay	INT			NULL,
    dayofweek		INT			NULL,
    quarter			INT			NULL,
    month			INT			NULL,
    year			INT			NULL,
    dayofyear		INT			NULL,
    dayofmonth		INT			NULL,
    weekofyear		INT			NULL,
    total_revenue_lag_7 FLOAT		NULL,
    rolling_mean_7	FLOAT		NULL,
    rolling_median_7 FLOAT		NULL,
    rolling_min_7	FLOAT		NULL,
    rolling_max_7	FLOAT		NULL,
    rolling_std_7	FLOAT		NULL
);



CREATE TABLE FT_WEEKLY_REVENUE (
	date			Date		NOT NULL,
    store_id		INT			NOT NULL,
    total_stock		FLOAT		NULL,
    average_price	FLOAT		NULL,
    dayofweek		INT			NULL,
    quarter			INT			NULL,
    month			INT			NULL,
    year			INT			NULL,
    dayofyear		INT			NULL,
    dayofmonth		INT			NULL,
    weekofyear		INT			NULL,
    total_revenue_lag_7 FLOAT		NULL,
    rolling_mean_7	FLOAT		NULL,
    rolling_median_7 FLOAT		NULL,
    rolling_min_7	FLOAT		NULL,
    rolling_max_7	FLOAT		NULL,
    rolling_std_7	FLOAT		NULL
);


CREATE TABLE FT_WEEKLY_SALES (
	date			Date		NOT NULL,
    store_id		INT			NOT NULL,
    total_stock		FLOAT		NULL,
    average_price	FLOAT		NULL,
    dayofweek		INT			NULL,
    quarter			INT			NULL,
    month			INT			NULL,
    year			INT			NULL,
    dayofyear		INT			NULL,
    dayofmonth		INT			NULL,
    weekofyear		INT			NULL,
    total_sales_lag_7 FLOAT		NULL,
    rolling_mean_7	FLOAT		NULL,
    rolling_median_7 FLOAT		NULL,
    rolling_min_7	FLOAT		NULL,
    rolling_max_7	FLOAT		NULL,
    rolling_std_7	FLOAT		NULL
);

CREATE TABLE FT_STORE (
	store_id			VarChar(50)		NOT NULL, 
	storetype_id		VarChar(50)		NOT NULL, 
	store_size			float			NULL,
	city_id				VarChar(50)		NOT NULL, 
	CONSTRAINT			FT_STORE_PK		PRIMARY KEY (store_id)
);

