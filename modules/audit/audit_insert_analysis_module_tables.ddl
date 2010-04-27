----------------------------------------------------------------------
--
-- Definitions for analysis audit insert table
--
----------------------------------------------------------------------
   DROP TABLE IF EXISTS analysis_audit_insert_tbl;
   CREATE TABLE analysis_audit_insert_tbl ( 
       analysis_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on analysis_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION analysis_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       analysis_id_var integer; 
   BEGIN
       analysis_id_var = NEW.analysis_id;

       INSERT INTO analysis_audit_insert_tbl ( 
             analysis_id
       ) VALUES ( 
             analysis_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS analysis_audit_insert_trgr ON analysis;
   CREATE TRIGGER analysis_audit_insert_trgr
       AFTER INSERT ON analysis
       FOR EACH ROW
       EXECUTE PROCEDURE analysis_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for analysisprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysisprop_audit_insert_tbl;
   CREATE TABLE analysisprop_audit_insert_tbl ( 
       analysisprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on analysisprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION analysisprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       analysisprop_id_var integer; 
   BEGIN
       analysisprop_id_var = NEW.analysisprop_id;

       INSERT INTO analysisprop_audit_insert_tbl ( 
             analysisprop_id
       ) VALUES ( 
             analysisprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS analysisprop_audit_insert_trgr ON analysisprop;
   CREATE TRIGGER analysisprop_audit_insert_trgr
       AFTER INSERT ON analysisprop
       FOR EACH ROW
       EXECUTE PROCEDURE analysisprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for analysisfeature audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysisfeature_audit_insert_tbl;
   CREATE TABLE analysisfeature_audit_insert_tbl ( 
       analysisfeature_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on analysisfeature_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION analysisfeature_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       analysisfeature_id_var integer; 
   BEGIN
       analysisfeature_id_var = NEW.analysisfeature_id;

       INSERT INTO analysisfeature_audit_insert_tbl ( 
             analysisfeature_id
       ) VALUES ( 
             analysisfeature_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS analysisfeature_audit_insert_trgr ON analysisfeature;
   CREATE TRIGGER analysisfeature_audit_insert_trgr
       AFTER INSERT ON analysisfeature
       FOR EACH ROW
       EXECUTE PROCEDURE analysisfeature_audit_insert_proc();

