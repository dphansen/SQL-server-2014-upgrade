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

-- Turn on advanced options
EXEC sp_configure 'Show Advanced Options', 1;
GO
RECONFIGURE;
GO


-- Set max server memory

-- Find the amount of physical memory in your server:

SELECT physical_memory_kb/1024 AS MemInMB
FROM sys.dm_os_sys_info 

-- Adjust `max server memory (MB)` option
-- Glenn Berry has some suggested Max Memory Settings for 
-- SQL Server 2005/2008: 
-- http://sqlserverperformance.wordpress.com/2009/10/29/suggested-max-memory-settings-for-sql-server-20052008/
-- Can also be used for SQL Server 2014, and is highly 
-- recommended to follow.


-- Set max server memory = 10,000 MB - in this case the server 
-- has 12 GB memory
EXEC sp_configure 'max server memory (MB)', 10000;
GO
RECONFIGURE;
GO






-- enable 'optimize for ad hoc workload'
-- Avoid plan cache bloat
-- http://blogs.msdn.com/b/timchapman/archive/2012/09/10/optimizing-ad-hoc-workloads.aspx

-- Enable optimize for ad hoc workloads
EXEC sp_configure 'optimize for ad hoc workloads', 1;
GO
RECONFIGURE;
GO







-- Enable DAC
-- http://www.brentozar.com/archive/2011/08/dedicated-admin-connection-why-want-when-need-how-tell-whos-using/

-- Enable DAC
EXEC sp_configure 'remote admin connections', 1;
GO
RECONFIGURE;
GO






-- Set cost threshold for parallelism
-- The optimizer uses that cost threshold to figure out when it should 
-- start evaluating plans that can use multiple threads.
-- 
-- Jeremiah Peschka (MVP) recommends setting this to 50, and then cut
-- back in case of performance problems. I would rather set it to 
-- 20-25 (which Jonathan Kehayis (MCM, MVP) recommends).
-- http://www.brentozar.com/archive/2013/09/five-sql-server-settings-to-change/
-- http://sqlblog.com/blogs/jonathan_kehayias/archive/2010/01/19/tuning-cost-threshold-of-parallelism-from-the-plan-cache.aspx

EXEC sp_configure 'cost threshold for parallelism', 25
GO
RECONFIGURE;
GO






-- Set max degree of parallelism

-- Limit parallelism to a number of physical cores 

-- http://support.microsoft.com/kb/2806535
-- More than eight processors: MAXDOP=8
-- Eight or fewer processors: MAXDOP=0 to N
-- N represents the number of processors.

-- For servers that have NUMA configured, MAXDOP should not exceed 
-- the number of CPUs that are assigned to each NUMA node.
-- For servers that have hyperthreading enabled, the MAXDOP value 
-- should not exceed the number of physical processors.
-- For servers that have NUMA configured and hyperthreading enabled, 
-- the MAXDOP value should not exceed number of physical processors 
-- per NUMA node.

EXEC sp_configure 'max degree of parallelism', 4
GO
RECONFIGURE;
GO






-- Enable default backup compression

EXEC sp_configure 'backup compression default', 1
GO
RECONFIGURE;
GO








-- Turn off advanced options
EXEC sp_configure 'Show Advanced Options', 0;
GO
RECONFIGURE;
GO

