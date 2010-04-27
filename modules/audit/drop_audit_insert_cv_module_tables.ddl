----------------------------------------------------------------------
--
-- Definitions for cv audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cv_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cv_audit_insert_proc();
   DROP TRIGGER IF EXISTS cv_audit_insert_trgr ON cv;

----------------------------------------------------------------------
--
-- Definitions for cvterm audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cvterm_audit_insert_proc();
   DROP TRIGGER IF EXISTS cvterm_audit_insert_trgr ON cvterm;

----------------------------------------------------------------------
--
-- Definitions for cvterm_relationship audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_relationship_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cvterm_relationship_audit_insert_proc();
   DROP TRIGGER IF EXISTS cvterm_relationship_audit_insert_trgr ON cvterm_relationship;

----------------------------------------------------------------------
--
-- Definitions for cvtermpath audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermpath_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cvtermpath_audit_insert_proc();
   DROP TRIGGER IF EXISTS cvtermpath_audit_insert_trgr ON cvtermpath;

----------------------------------------------------------------------
--
-- Definitions for cvtermsynonym audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermsynonym_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cvtermsynonym_audit_insert_proc();
   DROP TRIGGER IF EXISTS cvtermsynonym_audit_insert_trgr ON cvtermsynonym;

----------------------------------------------------------------------
--
-- Definitions for cvterm_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_dbxref_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cvterm_dbxref_audit_insert_proc();
   DROP TRIGGER IF EXISTS cvterm_dbxref_audit_insert_trgr ON cvterm_dbxref;

----------------------------------------------------------------------
--
-- Definitions for cvtermprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS cvtermprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS cvtermprop_audit_insert_trgr ON cvtermprop;

----------------------------------------------------------------------
--
-- Definitions for dbxrefprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxrefprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS dbxrefprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS dbxrefprop_audit_insert_trgr ON dbxrefprop;

