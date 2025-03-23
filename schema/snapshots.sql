CREATE DATABASE Board_Game1_Snap
ON
(
    NAME = Shop,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Board_Game1_Snaphot.ss'
)
AS SNAPSHOT OF Shop;
GO