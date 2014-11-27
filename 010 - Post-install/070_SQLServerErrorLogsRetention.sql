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
 
 
-- Configure SQL Server Error Logs retention
-- http://sqlblog.com/blogs/jonathan_kehayias/archive/2010/03/03/setting-sql-server-errorlog-retention-and-rollover-with-powershell.aspx). 

/*
 * Open SQL Server Management Studio
 * In `Object Explorer`, unfold `Management`
 * Right click on `SQL Server Logs` and click `Configure`
 * Check `Limit the number of error log files before they are recycled`
 * Write `30` in `Maximum number of error log files`
 * Click `OK`
 */

-- The above can also be done setting the registry value:
USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'NumErrorLogs', REG_DWORD, 30
GO


-- To create the rollover agent job, use the following T-SQL script:
USE [msdb]
GO

-- Add job
DECLARE @jobId BINARY(16)

EXEC  msdb.dbo.sp_add_job @job_name=N'SQL Server Error Logs Rollover', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@job_id = @jobId OUTPUT
GO

-- Add job to job server (the current server)
EXEC msdb.dbo.sp_add_jobserver @job_name=N'SQL Server Error Logs Rollover', @server_name = @@SERVERNAME
GO

-- Add job step to run cycle the SQL Server error log
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SQL Server Error Logs Rollover', @step_name=N'sp_cycle_errorlog', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sp_cycle_errorlog', 
		@database_name=N'master', 
		@flags=0
GO

-- Add job step that cycles the agent error log
EXEC msdb.dbo.sp_add_jobstep @job_name=N'SQL Server Error Logs Rollover', @step_name=N'sp_cycle_agent_errorlog', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC msdb.dbo.sp_cycle_agent_errorlog', 
		@database_name=N'master', 
		@flags=0
GO

-- Enable job
EXEC msdb.dbo.sp_update_job @job_name=N'SQL Server Error Logs Rollover', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'[Uncategorized (Local)]', 
		@notify_email_operator_name=N'', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO

-- Add schedule to run the job every night at midnight
DECLARE @start_date INT = YEAR(GETDATE()) * 10000 + MONTH(GETDATE()) * 100 + DAY(GETDATE())

DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'SQL Server Error Logs Rollover', @name=N'Nightly rollover', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=@start_date, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
GO
