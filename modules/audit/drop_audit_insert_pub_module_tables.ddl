----------------------------------------------------------------------
--
-- Definitions for pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS pub_audit_insert_trgr ON pub;

----------------------------------------------------------------------
--
-- Definitions for pub_relationship audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_relationship_audit_insert_tbl;
   DROP FUNCTION IF EXISTS pub_relationship_audit_insert_proc();
   DROP TRIGGER IF EXISTS pub_relationship_audit_insert_trgr ON pub_relationship;

----------------------------------------------------------------------
--
-- Definitions for pub_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_dbxref_audit_insert_tbl;
   DROP FUNCTION IF EXISTS pub_dbxref_audit_insert_proc();
   DROP TRIGGER IF EXISTS pub_dbxref_audit_insert_trgr ON pub_dbxref;

----------------------------------------------------------------------
--
-- Definitions for pubauthor audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubauthor_audit_insert_tbl;
   DROP FUNCTION IF EXISTS pubauthor_audit_insert_proc();
   DROP TRIGGER IF EXISTS pubauthor_audit_insert_trgr ON pubauthor;

----------------------------------------------------------------------
--
-- Definitions for pubprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS pubprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS pubprop_audit_insert_trgr ON pubprop;
