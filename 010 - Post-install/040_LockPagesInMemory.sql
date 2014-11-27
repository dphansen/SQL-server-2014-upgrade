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
 * Keep data in physical memory, preventing the system from paging 
 * the data to virtual memory on disk
 * 
 * Lock pages in memory -> Properties
 * Add User or Group
 * Locations...
 * Choose the local server and click OK
 * Enter the Service SID for SQL Server
 * Check Names
 * OK
 *
 * Further reading:
 * http://msdn.microsoft.com/en-us/library/ms190730.aspx
 * https://www.simple-talk.com/sql/database-administration/great-sql-server-debates-lock-pages-in-memory/
 */
