----------------------------------------------------------------------
--
-- Definitions for tableinfo audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS tableinfo_audit_insert_tbl;
   CREATE TABLE tableinfo_audit_insert_tbl ( 
       tableinfo_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on tableinfo_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION tableinfo_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       tableinfo_id_var integer; 
   BEGIN
       tableinfo_id_var = NEW.tableinfo_id;

       INSERT INTO tableinfo_audit_insert_tbl ( 
             tableinfo_id 
       ) VALUES ( 
             tableinfo_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS tableinfo_audit_insert_trgr ON tableinfo;
   CREATE TRIGGER tableinfo_audit_insert_trgr
       AFTER INSERT ON tableinfo
       FOR EACH ROW
       EXECUTE PROCEDURE tableinfo_audit_insert_proc ();

----------------------------------------------------------------------
--
-- Definitions for db audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS db_audit_insert_tbl;
   CREATE TABLE db_audit_insert_tbl ( 
       db_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on db_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION db_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       db_id_var integer; 
   BEGIN
       db_id_var = NEW.db_id;

       INSERT INTO db_audit_insert_tbl ( 
             db_id
       ) VALUES ( 
             db_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS db_audit_insert_trgr ON db;
   CREATE TRIGGER db_audit_insert_trgr
       AFTER INSERT ON db
       FOR EACH ROW
       EXECUTE PROCEDURE db_audit_insert_proc();


----------------------------------------------------------------------
--
-- Definitions for dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxref_audit_insert_tbl;
   CREATE TABLE dbxref_audit_insert_tbl ( 
       dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on dbxref_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION dbxref_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       dbxref_id_var integer; 
   BEGIN
       dbxref_id_var = NEW.dbxref_id;

       INSERT INTO dbxref_audit_insert_tbl ( 
             dbxref_id
       ) VALUES ( 
             dbxref_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS dbxref_audit_insert_trgr ON dbxref;
   CREATE TRIGGER dbxref_audit_insert_trgr
       AFTER INSERT ON dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE dbxref_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for project audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS project_audit_insert_tbl;
   CREATE TABLE project_audit_insert_tbl ( 
       project_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on project_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION project_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       project_id_var integer; 
   BEGIN
       project_id_var = NEW.project_id;

       INSERT INTO project_audit_insert_tbl ( 
             project_id
       ) VALUES ( 
             project_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS project_audit_insert_trgr ON project;
   CREATE TRIGGER project_audit_insert_trgr
       AFTER INSERT ON project
       FOR EACH ROW
       EXECUTE PROCEDURE project_audit_insert_proc();
