----------------------------------------------------------------------
--
-- Definitions for feature update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_audit_ud_trgr ON feature;

----------------------------------------------------------------------
--
-- Definitions for featureloc update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_audit_ud_tbl;
   DROP FUNCTION IF EXISTS featureloc_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS featureloc_audit_ud_trgr ON featureloc;

----------------------------------------------------------------------
--
-- Definitions for featureloc_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS featureloc_pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS featureloc_pub_audit_ud_trgr ON featureloc_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_pub_audit_ud_trgr ON feature_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_pubprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pubprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_pubprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_pubprop_audit_ud_trgr ON feature_pubprop;

----------------------------------------------------------------------
--
-- Definitions for featureprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS featureprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS featureprop_audit_ud_trgr ON featureprop;

----------------------------------------------------------------------
--
-- Definitions for featureprop_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS featureprop_pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS featureprop_pub_audit_ud_trgr ON featureprop_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxref_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_dbxref_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_dbxref_audit_ud_trgr ON feature_dbxref;

----------------------------------------------------------------------
--
-- Definitions for feature_dbxrefprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxrefprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_dbxrefprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_dbxrefprop_audit_ud_trgr ON feature_dbxrefprop;

----------------------------------------------------------------------
--
-- Definitions for feature_relationship update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_relationship_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_relationship_audit_ud_trgr ON feature_relationship;

----------------------------------------------------------------------
--
-- Definitions for feature_relationship_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_relationship_pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_relationship_pub_audit_ud_trgr ON feature_relationship_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_relatonshipprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_relationshipprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_relationshipprop_audit_ud_trgr ON feature_relationshipprop;

----------------------------------------------------------------------
--
-- Definitions for feature_relationshipprop_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_relationshipprop_pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_relationshipprop_pub_audit_ud_trgr ON feature_relationshipprop_pub;

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_cvterm_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_cvterm_audit_ud_trgr ON feature_cvterm;

----------------------------------------------------------------------
--
-- Definitions for feature_cvtermprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvtermprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_cvtermprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_cvtermprop_audit_ud_trgr ON feature_cvtermprop;

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_dbxref_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_cvterm_dbxref_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_cvterm_dbxref_audit_ud_trgr ON feature_cvterm_dbxref;

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_pub_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_cvterm_pub_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_cvterm_pub_audit_ud_trgr ON feature_cvterm_pub;

----------------------------------------------------------------------
--
-- Definitions for synonym update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS synonym_audit_ud_tbl;
   DROP FUNCTION IF EXISTS synonym_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS synonym_audit_ud_trgr ON synonym;

----------------------------------------------------------------------
--
-- Definitions for feature_synonym update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_synonym_audit_ud_tbl;
   DROP FUNCTION IF EXISTS feature_synonym_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS feature_synonym_audit_ud_trgr ON feature_synonym;

