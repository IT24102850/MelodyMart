# Database

MelodyMart runs on Microsoft SQL Server (2019+ or Azure SQL Database).

`schema.sql` in this folder is the single script that creates every table, trigger and
function the app needs, plus any seed data. It is exported from the working
`MelodyMartDB` database:

1. In SQL Server Management Studio, right-click **MelodyMartDB → Tasks → Generate Scripts…**
2. Choose **Script entire database and all database objects**.
3. Under **Advanced**, set **Types of data to script** to **Schema and data**
   (or **Schema only** for an empty store) and **Script for the database engine type**
   to **Microsoft Azure SQL Database** if you are deploying to Azure.
4. Save the file as `database/schema.sql`.

The older scratch scripts in `MelodyMart/src/main/sql/` are kept for history only;
they do not run cleanly on an empty database.
