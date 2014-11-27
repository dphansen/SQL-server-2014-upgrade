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
 * Configure Database Mail
 *
 * In Object Explorer, unfold `Management`
 * Right click on `Database Mail` and click `Configure Database Mail`
 * Click `Next` on the `Welcome to Database Mail Configuration Wizard`
 * Choose `Set up Database Mail by performing the following tasks` and click  `Next`
 * If the Database Mail feature is not enabled, you will get an alert about this. Click `Yes`.
 * Write a profile name under `Profile name` and a description under `Description`
 * Click `Add`
 * Enter an account name under `Account name`
 * Enter a description under `Description`
 * Enter the sender email address under `E-mail address`
 ** Note: This probably shouldn't be your own email address
 * Enter the email display name under `Display name`
 * Enter your SMTP server under `Server name`
 * Enter your SMTP's port number under `Port number`
 * Choose your SMTP Authendication, and type the username and password if needed.
 * Click `OK`
 * Click `Next`
 * Mark the checkbox under `Public`
 * Select `Yes` under `Default Profile`
 * Click `Next`
 * Click `Next` at the`Configure System Parameters` page
 * Click `Finish`
 * Click `Close`
 * Right click on `Database Mail` and click `Send Test E-Mail`
 * Enter your own email address in `To:`
 * Click `Send Test E-Mail`
 * When you have verified that you have received the email, click `OK`. Otherwise  you can click `Troubleshoot` to open help.
 */