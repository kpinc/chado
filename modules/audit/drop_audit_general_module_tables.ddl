----------------------------------------------------------------------
--
-- Definitions for tableinfo update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS tableinfo_audit_ud_tbl;
   DROP FUNCTION IF EXISTS tableinfo_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS tableinfo_audit_ud_trgr ON tableinfo;

----------------------------------------------------------------------
--
-- Definitions for db update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS db_audit_ud_tbl;
   DROP FUNCTION IF EXISTS db_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS db_audit_ud_trgr ON db;

----------------------------------------------------------------------
--
-- Definitions for dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxref_audit_ud_tbl;
   DROP FUNCTION IF EXISTS dbxref_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS dbxref_audit_ud_trgr ON dbxref;

----------------------------------------------------------------------
--
-- Definitions for project update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS project_audit_ud_tbl;
   DROP FUNCTION IF EXISTS project_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS project_audit_ud_trgr ON project;
