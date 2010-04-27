----------------------------------------------------------------------
--
-- Definitions for analysis update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysis_audit_ud_tbl;
   DROP FUNCTION IF EXISTS analysis_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS analysis_audit_ud_trgr ON analysis;

----------------------------------------------------------------------
--
-- Definitions for analysisprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysisprop_audit_ud_tbl;
   DROP FUNCTION IF EXISTS analysisprop_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS analysisprop_audit_ud_trgr ON analysisprop;

----------------------------------------------------------------------
--
-- Definitions for analysisfeature update/delete audit table
--
----------------------------------------------------------------------


   DROP TABLE IF EXISTS analysisfeature_audit_ud_tbl;
   DROP FUNCTION IF EXISTS analysisfeature_audit_update_delete_proc();
   DROP TRIGGER IF EXISTS analysisfeature_audit_ud_trgr ON analysisfeature;
