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
 
 
/*
 * Enable traceflags 1118 and 3226 on startup
 * Trace flag 1118 forces uniform extent allocations instead of mixed page 
 * allocations. The trace flag is commonly used to assist in TEMPDB 
 * scalability by avoiding SGAM and other allocation contention points. 
 *
 * 1118: Turns off mixed page allocations
 * http://www.sqlskills.com/blogs/paul/misconceptions-around-tf-1118/
 * http://support.microsoft.com/default.aspx?scid=kb;en-us;328551
 * http://support.microsoft.com/kb/2154845

 * 3226: Stops SQL Server from printing backup success message in the error log
 * http://technet.microsoft.com/en-us/library/ms188396.aspx

 * Start SQL Server Configuration Manager
 * Choose `SQL Server Services`
 * Right click on `SQL Server (MSSQLSERVER)` 
 *       (or the named instance you are using) and choose `Properties`
 * Click on the `Startup Parameters` tab
 * Enter `-T1118` under `Specify a startup parameter` and click `Add`
 * Enter `-T3226` under `Specify a startup parameter and click `Add`
 * Click `OK`
 * Click `OK` to the warning about restarting
 * Right click on `SQL Server` 
 *     (or the named instance you are using) and choose `Restart`
 */