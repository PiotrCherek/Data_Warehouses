CREATE DATABASE Board_Game_Snap2
ON
(
    NAME = Shop,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Board_Game1_Snaphot2.ss'
)
AS SNAPSHOT OF Shop;
GO

--CREATE DATABASE Board_Game2_Snap2
--ON
--(
-- NAME = Shop,
-- FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Board_Game1_Snaphot2.ss'
--)
--AS SNAPSHOT OF Shop;
--GO
