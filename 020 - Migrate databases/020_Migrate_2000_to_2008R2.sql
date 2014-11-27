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

-- Credit demo database by SQLskills
-- https://www.sqlskills.com/sql-server-resources/sql-server-demos/

USE [master]

-- Restore to SQL Server 2008 R2
RESTORE DATABASE [Credit] 
FROM DISK = N'C:\CampusDays\CreditBackup80.BAK' 
WITH REPLACE, FILE = 1,  
MOVE N'CreditData' TO N'P:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008R2\MSSQL\DATA\CreditData.mdf',  
MOVE N'CreditLog' TO N'L:\Program Files\Microsoft SQL Server\MSSQL10_50.SQL2008R2\MSSQL\Data\CreditLog.ldf',  
STATS = 5
GO



-- Take a new backup from the SQL Server 2008 R2 instance
BACKUP DATABASE [Credit] 
TO DISK = N'C:\CampusDays\CreditBackup100.bak' 
WITH NOFORMAT, INIT, STATS = 10, CHECKSUM
GO

-- Now go and restore to 2014