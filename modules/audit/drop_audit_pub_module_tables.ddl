----------------------------------------------------------------------
--
-- Definitions for pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS pub_audit_ud_trgr ON pub;

----------------------------------------------------------------------
--
-- Definitions for pub_relationship update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_relationship_audit_ud_tbl;
   DROP FUNCTION IF EXISTS pub_relationship_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS pub_relationship_audit_ud_trgr ON pub_relationship;

----------------------------------------------------------------------
--
-- Definitions for pub_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_dbxref_audit_ud_tbl;
   DROP FUNCTION IF EXISTS pub_dbxref_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS pub_dbxref_audit_ud_trgr ON pub_dbxref;

----------------------------------------------------------------------
--
-- Definitions for pubauthor update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubauthor_audit_ud_tbl;
   DROP FUNCTION IF EXISTS pubauthor_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS pubauthor_audit_ud_trgr ON pubauthor;

----------------------------------------------------------------------
--
-- Definitions for pubprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS pubprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS pubprop_audit_ud_trgr ON pubprop;
