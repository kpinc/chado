----------------------------------------------------------------------
--
-- Definitions for analysis update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysis_audit_ud_tbl;
   CREATE TABLE analysis_audit_ud_tbl ( 
       analysis_id integer, 
       name varchar(255), 
       description text, 
       program varchar(255), 
       programversion varchar(255), 
       algorithm varchar(255), 
       sourcename varchar(255), 
       sourceversion varchar(255), 
       sourceuri text, 
       timeexecuted timestamp, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on analysis_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION analysis_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       analysis_id_var integer; 
       name_var varchar(255); 
       description_var text; 
       program_var varchar(255); 
       programversion_var varchar(255); 
       algorithm_var varchar(255); 
       sourcename_var varchar(255); 
       sourceversion_var varchar(255); 
       sourceuri_var text; 
       timeexecuted_var timestamp; 
       
       transaction_type_var char;
   BEGIN
       analysis_id_var = OLD.analysis_id;
       name_var = OLD.name;
       description_var = OLD.description;
       program_var = OLD.program;
       programversion_var = OLD.programversion;
       algorithm_var = OLD.algorithm;
       sourcename_var = OLD.sourcename;
       sourceversion_var = OLD.sourceversion;
       sourceuri_var = OLD.sourceuri;
       timeexecuted_var = OLD.timeexecuted;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO analysis_audit_ud_tbl ( 
             analysis_id, 
             name, 
             description, 
             program, 
             programversion, 
             algorithm, 
             sourcename, 
             sourceversion, 
             sourceuri, 
             timeexecuted, 
             transaction_type
       ) VALUES ( 
             analysis_id_var, 
             name_var, 
             description_var, 
             program_var, 
             programversion_var, 
             algorithm_var, 
             sourcename_var, 
             sourceversion_var, 
             sourceuri_var, 
             timeexecuted_var, 
             transaction_type_var
       );

       IF TG_OP = ''DELETE'' THEN
           return OLD;
       ELSE
           return NEW;
       END IF;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS analysis_audit_ud_trgr ON analysis;
   CREATE TRIGGER analysis_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON analysis
       FOR EACH ROW
       EXECUTE PROCEDURE analysis_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for analysisprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS analysisprop_audit_ud_tbl;
   CREATE TABLE analysisprop_audit_ud_tbl ( 
       analysisprop_id integer, 
       analysis_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on analysisprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION analysisprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       analysisprop_id_var integer; 
       analysis_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       analysisprop_id_var = OLD.analysisprop_id;
       analysis_id_var = OLD.analysis_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO analysisprop_audit_ud_tbl ( 
             analysisprop_id, 
             analysis_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             analysisprop_id_var, 
             analysis_id_var, 
             type_id_var, 
             value_var, 
             rank_var, 
             transaction_type_var
       );

       IF TG_OP = ''DELETE'' THEN
           return OLD;
       ELSE
           return NEW;
       END IF;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS analysisprop_audit_ud_trgr ON analysisprop;
   CREATE TRIGGER analysisprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON analysisprop
       FOR EACH ROW
       EXECUTE PROCEDURE analysisprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for analysisfeature update/delete audit table
--
----------------------------------------------------------------------


   DROP TABLE IF EXISTS analysisfeature_audit_ud_tbl;
   CREATE TABLE analysisfeature_audit_ud_tbl ( 
       analysisfeature_id integer, 
       feature_id integer, 
       analysis_id integer, 
       rawscore float, 
       normscore float, 
       significance float, 
       identity float,  
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on analysisfeature_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION analysisfeature_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       analysisfeature_id_var integer; 
       feature_id_var integer; 
       analysis_id_var integer; 
       rawscore_var float; 
       normscore_var float; 
       significance_var float; 
       identity_var float; 
       
       transaction_type_var char;
   BEGIN
       analysisfeature_id_var = OLD.analysisfeature_id;
       feature_id_var = OLD.feature_id;
       analysis_id_var = OLD.analysis_id;
       rawscore_var = OLD.rawscore;
       normscore_var = OLD.normscore;
       significance_var = OLD.significance;
       identity_var = OLD.identity;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO analysisfeature_audit_ud_tbl ( 
             analysisfeature_id, 
             feature_id, 
             analysis_id, 
             rawscore, 
             normscore, 
             significance, 
             identity, 
             transaction_type
       ) VALUES ( 
             analysisfeature_id_var, 
             feature_id_var, 
             analysis_id_var, 
             rawscore_var, 
             normscore_var, 
             significance_var, 
             identity_var, 
             transaction_type_var
       );

       IF TG_OP = ''DELETE'' THEN
           return OLD;
       ELSE
           return NEW;
       END IF;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS analysisfeature_audit_ud_trgr ON analysisfeature;
   CREATE TRIGGER analysisfeature_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON analysisfeature
       FOR EACH ROW
       EXECUTE PROCEDURE analysisfeature_audit_update_delete_proc();

