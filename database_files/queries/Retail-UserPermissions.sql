-- Creating a new login
CREATE LOGIN PythonConnection WITH PASSWORD = 'PythonConnector3290.';
GO

USE Retail;
GO

-- Creating a user for the login
CREATE USER PythonConnection FOR LOGIN PythonConnection;
GO

-- Adding the user to the datareader role
EXEC sp_addrolemember 'db_datareader', 'PythonConnection';
GO
