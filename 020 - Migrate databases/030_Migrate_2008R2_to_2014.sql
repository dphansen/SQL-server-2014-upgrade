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

USE [master]

-- Restore 2008 R2 database to 2014
RESTORE DATABASE [Credit] 
FROM DISK = N'C:\CampusDays\CreditBackup100.BAK' 
WITH REPLACE, FILE = 1,  
MOVE N'CreditData' TO N'P:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CreditData.mdf',  
MOVE N'CreditLog' TO N'L:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Data\CreditLog.ldf',  
STATS = 5
