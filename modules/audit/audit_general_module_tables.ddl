----------------------------------------------------------------------
--
-- Definitions for tableinfo update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS tableinfo_audit_ud_tbl;
   CREATE TABLE tableinfo_audit_ud_tbl ( 
       tableinfo_id integer, 
       name varchar(30), 
       primary_key_column varchar(30), 
       is_view integer, 
       view_on_table_id integer, 
       superclass_table_id integer, 
       is_updateable integer, 
       modification_date date, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on tableinfo_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION tableinfo_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       tableinfo_id_var integer; 
       name_var varchar(30); 
       primary_key_column_var varchar(30); 
       is_view_var integer; 
       view_on_table_id_var integer; 
       superclass_table_id_var integer; 
       is_updateable_var integer; 
       modification_date_var date; 
       transaction_type_var char;

   BEGIN
       tableinfo_id_var = OLD.tableinfo_id;
       name_var = OLD.name;
       primary_key_column_var = OLD.primary_key_column;
       is_view_var = OLD.is_view;
       view_on_table_id_var = OLD.view_on_table_id;
       superclass_table_id_var = OLD.superclass_table_id;
       is_updateable_var = OLD.is_updateable;
       modification_date_var = OLD.modification_date;

       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO tableinfo_audit_ud_tbl ( 
             tableinfo_id, 
             name, 
             primary_key_column, 
             is_view, 
             view_on_table_id, 
             superclass_table_id, 
             is_updateable, 
             modification_date, 
             transaction_type
       ) VALUES ( 
             tableinfo_id_var, 
             name_var, 
             primary_key_column_var, 
             is_view_var, 
             view_on_table_id_var, 
             superclass_table_id_var, 
             is_updateable_var, 
             modification_date_var, 
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

   DROP TRIGGER IF EXISTS tableinfo_audit_ud_trgr ON tableinfo;
   CREATE TRIGGER tableinfo_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON tableinfo
       FOR EACH ROW
       EXECUTE PROCEDURE tableinfo_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for db update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS db_audit_ud_tbl;
   CREATE TABLE db_audit_ud_tbl ( 
       db_id integer, 
       name varchar(255), 
       description varchar(255), 
       urlprefix varchar(255), 
       url varchar(255), 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on db_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION db_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       db_id_var integer; 
       name_var varchar(255); 
       description_var varchar(255); 
       urlprefix_var varchar(255); 
       url_var varchar(255); 
       transaction_type_var char;
   BEGIN
       db_id_var = OLD.db_id;
       name_var = OLD.name;
       description_var = OLD.description;
       urlprefix_var = OLD.urlprefix;
       url_var = OLD.url;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO db_audit_ud_tbl ( 
             db_id, 
              name, 
             description, 
             urlprefix, 
             url, 
             transaction_type
       ) VALUES ( 
             db_id_var, 
             name_var, 
             description_var, 
             urlprefix_var, 
             url_var, 
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

   DROP TRIGGER IF EXISTS db_audit_ud_trgr ON db;
   CREATE TRIGGER db_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON db
       FOR EACH ROW
       EXECUTE PROCEDURE db_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxref_audit_ud_tbl;
   CREATE TABLE dbxref_audit_ud_tbl ( 
       dbxref_id integer, 
       db_id integer, 
       accession varchar(255), 
       version varchar(255), 
       description text, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on dbxref_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION dbxref_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       dbxref_id_var integer; 
       db_id_var integer; 
       accession_var varchar(255); 
       version_var varchar(255); 
       description_var text; 
       transaction_type_var char;
   BEGIN
       dbxref_id_var = OLD.dbxref_id;
       db_id_var = OLD.db_id;
       accession_var = OLD.accession;
       version_var = OLD.version;
       description_var = OLD.description;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO dbxref_audit_ud_tbl ( 
             dbxref_id, 
             db_id, 
             accession, 
             version, 
             description, 
             transaction_type
       ) VALUES ( 
             dbxref_id_var, 
             db_id_var, 
             accession_var, 
             version_var, 
             description_var, 
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

   DROP TRIGGER IF EXISTS dbxref_audit_ud_trgr ON dbxref;
   CREATE TRIGGER dbxref_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE dbxref_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for project update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS project_audit_ud_tbl;
   CREATE TABLE project_audit_ud_tbl ( 
       project_id integer, 
       name varchar(255), 
       description varchar(255), 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on project_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION project_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       project_id_var integer; 
       name_var varchar(255); 
       description_var varchar(255); 
       transaction_type_var char;
   BEGIN
       project_id_var = OLD.project_id;
       name_var = OLD.name;
       description_var = OLD.description;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO project_audit_ud_tbl ( 
             project_id, 
             name, 
             description, 
             transaction_type
       ) VALUES ( 
             project_id_var, 
             name_var, 
             description_var, 
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

   DROP TRIGGER IF EXISTS project_audit_ud_trgr ON project;
   CREATE TRIGGER project_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON project
       FOR EACH ROW
       EXECUTE PROCEDURE project_audit_update_delete_proc ();
