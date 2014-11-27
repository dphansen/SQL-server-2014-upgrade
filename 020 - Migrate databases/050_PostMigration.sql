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

-- Check settings
-- Compatibility level <> 120
-- Page verify option - should be CHECKSUM
-- Auto close should be off
-- Auto shrink should be off
SELECT db.[name] AS DatabaseName
	, db.recovery_model_desc 
	, db.state_desc
	, db.compatibility_level 
	, db.page_verify_option_desc 
	, db.is_auto_create_stats_on
	, db.is_auto_update_stats_on
	, db.is_auto_update_stats_async_on
	, db.is_parameterization_forced
	, db.is_auto_close_on
	, db.is_auto_shrink_on
FROM sys.databases AS db 



USE [master]
GO

-- Change TORN_PAGE_DETECTION to CHECKSUM
ALTER DATABASE [Credit] SET PAGE_VERIFY CHECKSUM  WITH NO_WAIT
GO


-- Upgrade compatibility level
ALTER DATABASE [Credit] SET COMPATIBILITY_LEVEL = 120
ALTER DATABASE [Sales] SET COMPATIBILITY_LEVEL = 120
GO


-- Check again
SELECT db.[name] AS DatabaseName
	, db.recovery_model_desc 
	, db.state_desc
	, db.compatibility_level 
	, db.page_verify_option_desc 
	, db.is_auto_create_stats_on
	, db.is_auto_update_stats_on
	, db.is_auto_update_stats_async_on
	, db.is_parameterization_forced
	, db.is_auto_close_on
	, db.is_auto_shrink_on
FROM sys.databases AS db 




-- For each migrated database, do the following:
USE Credit
GO

-- Update statistics for all tables in a database
-- Do this for all databases
-- Very important with new cardinality estimator
EXEC sp_MSforeachtable @command1='UPDATE STATISTICS ? WITH FULLSCAN';

-- Updates the metadata for the specified 
-- non-schema-bound view. Persistent metadata for a view 
-- can become outdated because of changes to the underlying
-- objects upon which the view depends.
EXEC sp_refreshview 'basic_member'
EXEC sp_refreshview 'charge_wide'
EXEC sp_refreshview 'corp_member'
EXEC sp_refreshview 'overdue'
EXEC sp_refreshview 'payment_wide'
EXEC sp_refreshview 'statement_wide'



-- The end