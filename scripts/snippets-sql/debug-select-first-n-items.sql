-- Strategy:
-- 1) print/console.log = Select a couple things (fast operation)
-- 2) Iterative building of commands (like mongo)
--
--
-- Select from table:
SELECT * FROM TABLE_A;
--
--
-- Select first N items from table:
-- https://stackoverflow.com/questions/1891789/sql-select-first-10-rows-only
-- https://www.w3schools.com/sql/sql_top.asp
--
-- Depends on your RDBMS:
--
-- MySQL, PostgreSQL:
SELECT * FROM TABLE_A LIMIT 10;
--
-- MS SQL Server:
SELECT TOP 10 * FROM TABLE_A;
--
-- Sybase:
SET ROWCOUNT 10 SELECT * FROM TABLE_A;
--
-- ANSI SQL:
SELECT * FROM TABLE_A FETCH FIRST 10 ROWS ONLY;
--
-- Etc.
--
