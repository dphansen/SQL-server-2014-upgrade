/* Demo script for Upgrading to SQL Server 2014
 *
 * Written by David Peter Hansen 
 * @dphansen | davidpeterhansen.com
 *
 * This script is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


/* Enable instant file initialisation
 *
 * Run secpol.msc
 * Local Policies -> User Right Assignment
 * Perform volumne maintenance tasks -> Properties
 * Add User or Group
 * Locations...
 * Choose the local server and click `OK`
 * Enter the Service SID for SQL Server
 *
 * For the default instance of SQL Server, the Service SID is 
 * NT SERVICE\MSSQLSERVER
 * For named instances, the Service SID is MSSQL$<instancename> where  
 * <instancename> is the name of the instance. E.g. if my instance is called 
 * `SQL2014`, then the Service SID would be `MSSQL$SQL2014`.
 * 
 * Check Names -> OK
 * Keep the Local Security Policy open to add Lock pages in memory 
 *
 * Further reading:
 * http://blogs.msdn.com/b/sql_pfe_blog/archive/2009/12/23/how-and-why-to-enable-instant-file-initialization.aspx
 * http://www.brentozar.com/archive/2013/07/will-instant-file-initialization-really-help-my-databases/
 * http://www.sqlskills.com/blogs/paul/how-to-tell-if-you-have-instant-initialization-enabled/
 * http://www.sqlskills.com/blogs/bobb/about-sql-servers-usage-of-service-sids/
 */