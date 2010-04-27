----------------------------------------------------------------------
--
-- Definitions for analysis audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysis_audit_insert_tbl;
   DROP FUNCTION IF EXISTS analysis_audit_insert_proc();
   DROP TRIGGER IF EXISTS analysis_audit_insert_trgr ON analysis;

----------------------------------------------------------------------
--
-- Definitions for analysisprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysisprop_audit_insert_tbl;
   DROP FUNCTION IF EXISTS analysisprop_audit_insert_proc();
   DROP TRIGGER IF EXISTS analysisprop_audit_insert_trgr ON analysisprop;

----------------------------------------------------------------------
--
-- Definitions for analysisfeature audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysisfeature_audit_insert_tbl;
   DROP FUNCTION IF EXISTS analysisfeature_audit_insert_proc();
   DROP TRIGGER IF EXISTS analysisfeature_audit_insert_trgr ON analysisfeature;
