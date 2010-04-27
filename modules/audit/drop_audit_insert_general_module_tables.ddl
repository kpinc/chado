----------------------------------------------------------------------
--
-- Definitions for tableinfo audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS tableinfo_audit_insert_tbl;
   DROP FUNCTION IF EXISTS tableinfo_audit_insert_proc();
   DROP TRIGGER IF EXISTS tableinfo_audit_insert_trgr ON tableinfo;

----------------------------------------------------------------------
--
-- Definitions for db audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS db_audit_insert_tbl;
   DROP FUNCTION IF EXISTS db_audit_insert_proc();
   DROP TRIGGER IF EXISTS db_audit_insert_trgr ON db;

----------------------------------------------------------------------
--
-- Definitions for dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxref_audit_insert_tbl;
   DROP FUNCTION IF EXISTS dbxref_audit_insert_proc();
   DROP TRIGGER IF EXISTS dbxref_audit_insert_trgr ON dbxref;

----------------------------------------------------------------------
--
-- Definitions for project audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS project_audit_insert_tbl;
   DROP FUNCTION IF EXISTS project_audit_insert_proc();
   DROP TRIGGER IF EXISTS project_audit_insert_trgr ON project;
