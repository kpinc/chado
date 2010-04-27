----------------------------------------------------------------------
--
-- Definitions for organism audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_audit_insert_tbl;
   DROP FUNCTION IF EXISTS organism_audit_insert_proc();
   DROP TRIGGER IF EXISTS organism_audit_insert_trgr ON organism;

----------------------------------------------------------------------
--
-- Definitions for organism_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_dbxref_audit_insert_tbl;
   DROP FUNCTION IF EXISTS organism_dbxref_audit_insert_proc();
   DROP TRIGGER IF EXISTS organism_dbxref_audit_insert_trgr;

----------------------------------------------------------------------
--
-- Definitions for organismprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organismprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS organismprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS organismprop_audit_insert_trgr ON organismprop;
