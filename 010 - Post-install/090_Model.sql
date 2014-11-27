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

-- NOTE NOTE NOTE: I have set MB to KB to not fill out the drive.
-- This is for demo purposes... change back to MB if used for real.


-- Change model database settings
-- Every new user database is modelled after model.

ALTER DATABASE [model] SET RECOVERY SIMPLE WITH NO_WAIT
GO

ALTER DATABASE [model] 
MODIFY FILE ( NAME = N'modeldev', SIZE = 8192KB , FILEGROWTH = 8192KB )
GO

ALTER DATABASE [model] 
MODIFY FILE ( NAME = N'modellog', SIZE = 8000KB , FILEGROWTH = 8000KB)
GO
