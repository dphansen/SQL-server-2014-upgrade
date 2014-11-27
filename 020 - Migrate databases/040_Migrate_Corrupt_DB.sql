/* Demo script for Upgrading to SQL Server 2014
 *
 * Written by David Peter Hansen 
 * @dphansen | davidpeterhansen.com
 *
 * This script is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

-- Demo database by Paul Randal, SQLskills
-- http://www.sqlskills.com/blogs/paul/corruption-demo-databases-and-scripts/

-- Demo script inspired by Paul Randal's demo script


USE [master]


-- Restore Sales database
RESTORE DATABASE [Sales] 
FROM DISK = N'C:\CampusDays\Sales.bak'
WITH REPLACE, STATS = 10,
MOVE N'SalesDBData' TO N'P:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sales.mdf',
MOVE N'SalesDBLog' TO N'L:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Data\Sales_log.ldf';
GO




-- Always run CHECKDB after a restore...
DBCC CHECKDB (Sales)
WITH NO_INFOMSGS, ALL_ERRORMSGS;
GO







-- Aiya! Errors...




-- Something is wrong... let's look a bit closer where it is.
DBCC CHECKDB (Sales)
WITH NO_INFOMSGS, ALL_ERRORMSGS, TABLERESULTS;
GO














-- It is the nonclustered index that is corrupt.
-- We can just rebuild that. Yay!


-- Find the index
USE Sales
GO
EXEC sp_HelpIndex 'Customers';
GO

-- Disable and rebuild it... (rebuild is not enough)
ALTER INDEX CustomerName ON Customers DISABLE
ALTER INDEX CustomerName ON Customers REBUILD
GO

-- ... and check again
DBCC CHECKDB (Sales)
WITH NO_INFOMSGS, ALL_ERRORMSGS;
GO
