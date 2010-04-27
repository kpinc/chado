----------------------------------------------------------------------
--
-- Definitions for feature audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_audit_insert_trgr ON feature;

----------------------------------------------------------------------
--
-- Definitions for featureloc audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_audit_insert_tbl;
   DRO FUNCTION IF EXISTS featureloc_audit_insert_proc();
   DROP TRIGGER IF EXISTS featureloc_audit_insert_trgr ON featureloc;

----------------------------------------------------------------------
--
-- Definitions for featureloc_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS featureloc_pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS featureloc_pub_audit_insert_trgr ON featureloc_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_pub_audit_insert_trgr ON feature_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_pubprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pubprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_pubprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_pubprop_audit_insert_trgr ON feature_pubprop;

----------------------------------------------------------------------
--
-- Definitions for featureprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS featureprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS featureprop_audit_insert_trgr ON featureprop;

----------------------------------------------------------------------
--
-- Definitions for featureprop_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS featureprop_pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS featureprop_pub_audit_insert_trgr ON featureprop_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxref_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_dbxref_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_dbxref_audit_insert_trgr ON feature_dbxref;

----------------------------------------------------------------------
--
-- Definitions for feature_dbxrefprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxrefprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_dbxrefprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_dbxrefprop_audit_insert_trgr ON feature_dbxrefprop;

----------------------------------------------------------------------
--
-- Definitions for feature_relationship audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_relationship_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_relationship_audit_insert_trgr ON feature_relationship;

----------------------------------------------------------------------
--
-- Definitions for feature_relationship_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_relationship_pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_relationship_pub_audit_insert_trgr ON feature_relationship_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_relationshipprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_relationshipprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_relationshipprop_audit_insert_trgr ON feature_relationshipprop;

----------------------------------------------------------------------
--
-- Definitions for feature_relationshipprop_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_relationshipprop_pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_relationshipprop_pub_audit_insert_trgr ON feature_relationshipprop_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_cvterm_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_cvterm_audit_insert_trgr ON feature_cvterm;

----------------------------------------------------------------------
--
-- Definitions for feature_cvtermprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvtermprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_cvtermprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_cvtermprop_audit_insert_trgr ON feature_cvtermprop;

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_dbxref_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_cvterm_dbxref_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_cvterm_dbxref_audit_insert_trgr ON feature_cvterm_dbxref;

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_pub_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_cvterm_pub_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_cvterm_pub_audit_insert_trgr ON feature_cvterm_pub;

----------------------------------------------------------------------
--
-- Definitions for synonym audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS synonym_audit_insert_tbl;
   DRO FUNCTION IF EXISTS synonym_audit_insert_proc();
   DROP TRIGGER IF EXISTS synonym_audit_insert_trgr ON synonym;

----------------------------------------------------------------------
--
-- Definitions for feature_synonym audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_synonym_audit_insert_tbl;
   DROP FUNCTION IF EXISTS feature_synonym_audit_insert_proc();
   DROP TRIGGER IF EXISTS feature_synonym_audit_insert_trgr ON feature_synonym;
