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
 

-- Size tempdb
/*
 * Always use a dedicated LUN / RAID array / spindles for tempdb 
 * Preferable some very very fast storage, such as FusionIO or Violin
 *
 * The number of data files for tempdb depends on the logical cores for 
 * the servers.
 *
 * < 8 logical cores -> same number of data files as cores
 * >= 8 logical cores -> 8 data files
 *
 * Add more in chunks of 4 if you see PFS contention
 *
 * http://www.sqlskills.com/blogs/paul/the-accidental-dba-day-27-of-30-troubleshooting-tempdb-contention/
 * https://www.simple-talk.com/sql/database-administration/optimizing-tempdb-configuration-with-sql-server-2012-extended-events/
 *
 * The size of the data files should be set to an appropriate size, 
 * depending on the size of the IO subsystem
 * For better VLF count, set the transaction log to 8000 MB (not 8 GB) 
 * with filegrowth to 8000 MB (not 8GB).
 * Make sure all files has the same growthsize set.
 * http://www.sqlskills.com/blogs/kimberly/transaction-log-vlfs-too-many-or-too-few/
 * See also http://www.sqlskills.com/blogs/paul/tempdb-configuration-survey-results-and-advice/
 */

-- NOTE NOTE NOTE: I have set MB to KB to not fill out the drive.
-- This is for demo purposes... change back to MB if used for real.


USE [master]
GO

ALTER DATABASE [tempdb] 
MODIFY FILE (NAME=N'tempdev', NEWNAME=N'tempdb1')
GO

ALTER DATABASE [tempdb] 
MODIFY FILE ( NAME = N'tempdb1', SIZE = 8192KB , FILEGROWTH = 8192KB )
GO

ALTER DATABASE [tempdb] 
MODIFY FILE ( NAME = N'templog', SIZE = 8000KB , FILEGROWTH = 8000KB )
GO

ALTER DATABASE [tempdb] 
ADD FILE ( NAME = N'tempdb2'
	, FILENAME = N'T:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\tempdb2.ndf' 
	, SIZE = 8192KB , FILEGROWTH = 8192KB )
GO

ALTER DATABASE [tempdb] 
ADD FILE ( NAME = N'tempdb3'
	, FILENAME = N'T:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\tempdb3.ndf' 
	, SIZE = 8192KB , FILEGROWTH = 8192KB )
GO
ALTER DATABASE [tempdb] 
ADD FILE ( NAME = N'tempdb4'
	, FILENAME = N'T:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\tempdb4.ndf' 
	, SIZE = 8192KB , FILEGROWTH = 8192KB )
GO
