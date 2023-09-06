USE Retail;
GO

BULK INSERT PRODUCT
FROM '\database_files\datasets\product_normalized.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT PRODUCT_HIERARCHY
FROM '\database_files\datasets\hierarchy_normalized.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT STORE
FROM '\database_files\datasets\store_cities.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT SALES
FROM '\database_files\datasets\sales_normalized.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT PROMO
FROM '\database_files\datasets\promo_normalized.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


BULK INSERT FT_STORE
FROM '\database_files\datasets\features\ft_store_cities.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT FT_DAILY_SALES
FROM '\database_files\datasets\features\ft_daily_sales.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT FT_DAILY_REVENUE
FROM '\database_files\datasets\features\ft_daily_revenue.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT FT_WEEKLY_REVENUE
FROM '\database_files\datasets\features\ft_weekly_revenue.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT FT_WEEKLY_SALES	
FROM '\database_files\datasets\features\ft_weekly_sales.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


