----------------------------------------------------------------------
--
-- Definitions for cv update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cv_audit_ud_tbl;
   CREATE TABLE cv_audit_ud_tbl ( 
       cv_id integer, 
       name varchar(255), 
       definition text, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cv_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cv_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cv_id_var integer; 
       name_var varchar(255); 
       definition_var text; 
       
       transaction_type_var char;
   BEGIN
       cv_id_var = OLD.cv_id;
       name_var = OLD.name;
       definition_var = OLD.definition;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO audit_cv ( 
             cv_id, 
             name, 
             definition, 
             transaction_type
       ) VALUES ( 
             cv_id_var, 
             name_var, 
             definition_var, 
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

   DROP TRIGGER IF EXISTS cv_audit_ud_trgr ON cv;
   CREATE TRIGGER cv_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cv
       FOR EACH ROW
       EXECUTE PROCEDURE cv_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for cvterm update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_audit_ud_tbl;
   CREATE TABLE cvterm_audit_ud_tbl ( 
       cvterm_id integer, 
       cv_id integer, 
       name varchar(1024), 
       definition text, 
       dbxref_id integer, 
       is_obsolete integer, 
       is_relationshiptype integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cvterm_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvterm_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cvterm_id_var integer; 
       cv_id_var integer; 
       name_var varchar(1024); 
       definition_var text; 
       dbxref_id_var integer; 
       is_obsolete_var integer; 
       is_relationshiptype_var integer; 
       
       transaction_type_var char;
   BEGIN
       cvterm_id_var = OLD.cvterm_id;
       cv_id_var = OLD.cv_id;
       name_var = OLD.name;
       definition_var = OLD.definition;
       dbxref_id_var = OLD.dbxref_id;
       is_obsolete_var = OLD.is_obsolete;
       is_relationshiptype_var = OLD.is_relationshiptype;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO cvterm_audit_ud_tbl ( 
             cvterm_id, 
             cv_id, 
             name, 
             definition, 
             dbxref_id, 
             is_obsolete, 
             is_relationshiptype, 
             transaction_type
       ) VALUES ( 
             cvterm_id_var, 
             cv_id_var, 
             name_var, 
             definition_var, 
             dbxref_id_var, 
             is_obsolete_var, 
             is_relationshiptype_var, 
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

   DROP TRIGGER IF EXISTS cvterm_audit_ud_trgr ON cvterm;
   CREATE TRIGGER cvterm_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cvterm
       FOR EACH ROW
       EXECUTE PROCEDURE cvterm_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for cvterm_relationship update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_relationship_audit_ud_tbl;
   CREATE TABLE cvterm_relationship_audit_ud_tbl ( 
       cvterm_relationship_id integer, 
       type_id integer, 
       subject_id integer, 
       object_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cvterm_relationship_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvterm_relationship_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cvterm_relationship_id_var integer; 
       type_id_var integer; 
       subject_id_var integer; 
       object_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       cvterm_relationship_id_var = OLD.cvterm_relationship_id;
       type_id_var = OLD.type_id;
       subject_id_var = OLD.subject_id;
       object_id_var = OLD.object_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO cvterm_relationship_audit_ud_tbl ( 
             cvterm_relationship_id, 
             type_id, 
             subject_id, 
             object_id, 
             transaction_type
       ) VALUES ( 
             cvterm_relationship_id_var, 
             type_id_var, 
             subject_id_var, 
             object_id_var, 
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

   DROP TRIGGER IF EXISTS cvterm_relationship_audit_ud_trgr ON cvterm_relationship;
   CREATE TRIGGER cvterm_relationship_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cvterm_relationship
       FOR EACH ROW
       EXECUTE PROCEDURE cvterm_relationship_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for cvtermpath update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermpath_audit_ud_tbl;
   CREATE TABLE cvtermpath_audit_ud_tbl ( 
       cvtermpath_id integer, 
       type_id integer, 
       subject_id integer, 
       object_id integer, 
       cv_id integer, 
       pathdistance integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cvtermpath_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvtermpath_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cvtermpath_id_var integer; 
       type_id_var integer; 
       subject_id_var integer; 
       object_id_var integer; 
       cv_id_var integer; 
       pathdistance_var integer; 
       
       transaction_type_var char;
   BEGIN
       cvtermpath_id_var = OLD.cvtermpath_id;
       type_id_var = OLD.type_id;
       subject_id_var = OLD.subject_id;
       object_id_var = OLD.object_id;
       cv_id_var = OLD.cv_id;
       pathdistance_var = OLD.pathdistance;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO cvtermpath_audit_ud_tbl ( 
             cvtermpath_id, 
             type_id, 
             subject_id, 
             object_id, 
             cv_id, 
             pathdistance, 
             transaction_type
       ) VALUES ( 
             cvtermpath_id_var, 
             type_id_var, 
             subject_id_var, 
             object_id_var, 
             cv_id_var, 
             pathdistance_var, 
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

   DROP TRIGGER IF EXISTS cvtermpath_audit_ud_trgr ON cvtermpath;
   CREATE TRIGGER cvtermpath_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cvtermpath
       FOR EACH ROW
       EXECUTE PROCEDURE cvtermpath_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for cvtermsynonym update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermsynonym_audit_ud_tbl;
   CREATE TABLE cvtermsynonym_audit_ud_tbl ( 
       cvtermsynonym_id integer, 
       cvterm_id integer, 
       synonym varchar(1024), 
       type_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cvtermsynonym_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvtermsynonym_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cvtermsynonym_id_var integer; 
       cvterm_id_var integer; 
       synonym_var varchar(1024); 
       type_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       cvtermsynonym_id_var = OLD.cvtermsynonym_id;
       cvterm_id_var = OLD.cvterm_id;
       synonym_var = OLD.synonym;
       type_id_var = OLD.type_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO cvtermsynonym_audit_ud_tbl ( 
             cvtermsynonym_id, 
             cvterm_id, 
             synonym, 
             type_id, 
             transaction_type
       ) VALUES ( 
             cvtermsynonym_id_var, 
             cvterm_id_var, 
             synonym_var, 
             type_id_var, 
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

   DROP TRIGGER IF EXISTS cvtermsynonym_audit_ud_trgr ON cvtermsynonym;
   CREATE TRIGGER cvtermsynonym_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cvtermsynonym
       FOR EACH ROW
       EXECUTE PROCEDURE cvtermsynonym_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for cvterm_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_dbxref_audit_ud_tbl;
   CREATE TABLE cvterm_dbxref_audit_ud_tbl ( 
       cvterm_dbxref_id integer, 
       cvterm_id integer, 
       dbxref_id integer, 
       is_for_definition integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cvterm_dbxref_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvterm_dbxref_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cvterm_dbxref_id_var integer; 
       cvterm_id_var integer; 
       dbxref_id_var integer; 
       is_for_definition_var integer; 
       
       transaction_type_var char;
   BEGIN
       cvterm_dbxref_id_var = OLD.cvterm_dbxref_id;
       cvterm_id_var = OLD.cvterm_id;
       dbxref_id_var = OLD.dbxref_id;
       is_for_definition_var = OLD.is_for_definition;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO cvterm_dbxref_audit_ud_tbl ( 
             cvterm_dbxref_id, 
             cvterm_id, 
             dbxref_id, 
             is_for_definition, 
             transaction_type
       ) VALUES ( 
             cvterm_dbxref_id_var, 
             cvterm_id_var, 
             dbxref_id_var, 
             is_for_definition_var, 
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

   DROP TRIGGER IF EXISTS cvterm_dbxref_audit_ud_trgr ON cvterm_dbxref;
   CREATE TRIGGER cvterm_dbxref_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cvterm_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE cvterm_dbxref_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for cvtermprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermprop_audit_ud_tbl;
   CREATE TABLE cvtermprop_audit_ud_tbl ( 
       cvtermprop_id integer, 
       cvterm_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on cvtermprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvtermprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       cvtermprop_id_var integer; 
       cvterm_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       cvtermprop_id_var = OLD.cvtermprop_id;
       cvterm_id_var = OLD.cvterm_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO cvtermprop_audit_ud_tbl ( 
             cvtermprop_id, 
             cvterm_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             cvtermprop_id_var, 
             cvterm_id_var, 
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

   DROP TRIGGER IF EXISTS cvtermprop_audit_ud_trgr ON cvtermprop;
   CREATE TRIGGER cvtermprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON cvtermprop
       FOR EACH ROW
       EXECUTE PROCEDURE cvtermprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for dbxrefprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxrefprop_audit_ud_tbl;
   CREATE TABLE dbxrefprop_audit_ud_tbl ( 
       dbxrefprop_id integer, 
       dbxref_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on dbxrefprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION dbxrefprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       dbxrefprop_id_var integer; 
       dbxref_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       dbxrefprop_id_var = OLD.dbxrefprop_id;
       dbxref_id_var = OLD.dbxref_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO dbxrefprop_audit_ud_tbl ( 
             dbxrefprop_id, 
             dbxref_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             dbxrefprop_id_var, 
             dbxref_id_var, 
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

   DROP TRIGGER IF EXISTS dbxrefprop_audit_ud_trgr ON dbxrefprop;
   CREATE TRIGGER dbxrefprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON dbxrefprop
       FOR EACH ROW
       EXECUTE PROCEDURE dbxrefprop_audit_update_delete_proc();

