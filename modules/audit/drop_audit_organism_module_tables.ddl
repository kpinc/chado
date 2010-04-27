----------------------------------------------------------------------
--
-- Definitions for organism update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_audit_ud_tbl;
   DROP FUNCTION IF EXISTS organism_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS organism_audit_ud_trgr ON organism;

----------------------------------------------------------------------
--
-- Definitions for organism_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_dbxref_audit_ud_tbl;
   DROP FUNCTION IF EXISTS organism_dbxref_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS organism_dbxref_audit_ud_trgr ON organism_dbxref;

----------------------------------------------------------------------
--
-- Definitions for organismprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organismprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS organismprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS organismprop_audit_ud_trgr ON organismprop;
