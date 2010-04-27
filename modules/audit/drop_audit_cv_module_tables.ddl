----------------------------------------------------------------------
--
-- Definitions for cv update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cv_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cv_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cv_audit_ud_trgr ON cv;

----------------------------------------------------------------------
--
-- Definitions for cvterm update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cvterm_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cvterm_audit_ud_trgr ON cvterm;

----------------------------------------------------------------------
--
-- Definitions for cvterm_relationship update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_relationship_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cvterm_relationship_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cvterm_relationship_audit_ud_trgr ON cvterm_relationship;

----------------------------------------------------------------------
--
-- Definitions for cvtermpath update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermpath_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cvtermpath_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cvtermpath_audit_ud_trgr ON cvtermpath;

----------------------------------------------------------------------
--
-- Definitions for cvtermsynonym update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermsynonym_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cvtermsynonym_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cvtermsynonym_audit_ud_trgr ON cvtermsynonym;

----------------------------------------------------------------------
--
-- Definitions for cvterm_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_dbxref_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cvterm_dbxref_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cvterm_dbxref_audit_ud_trgr ON cvterm_dbxref;

----------------------------------------------------------------------
--
-- Definitions for cvtermprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS cvtermprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS cvtermprop_audit_ud_trgr ON cvtermprop;

----------------------------------------------------------------------
--
-- Definitions for dbxrefprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxrefprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS dbxrefprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS dbxrefprop_audit_ud_trgr ON dbxrefprop;
