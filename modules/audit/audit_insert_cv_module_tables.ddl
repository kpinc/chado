----------------------------------------------------------------------
--
-- Definitions for cv audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cv_audit_insert_tbl;

   CREATE TABLE cv_audit_insert_tbl ( 
       cv_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cv_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cv_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cv_id_var integer; 
   BEGIN
       cv_id_var = NEW.cv_id;

       INSERT INTO cv_audit_insert_tbl ( 
             cv_id
       ) VALUES ( 
             cv_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cv_audit_insert_trgr ON cv;
   CREATE TRIGGER cv_audit_insert_trgr
       AFTER INSERT ON cv
       FOR EACH ROW
       EXECUTE PROCEDURE cv_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for cvterm audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_audit_insert_tbl;

   CREATE TABLE cvterm_audit_insert_tbl ( 
       cvterm_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cvterm_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvterm_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cvterm_id_var integer; 
   BEGIN
       cvterm_id_var = NEW.cvterm_id;

       INSERT INTO cvterm_audit_insert_tbl ( 
             cvterm_id
       ) VALUES ( 
             cvterm_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cvterm_audit_insert_trgr ON cvterm;
   CREATE TRIGGER cvterm_audit_insert_trgr
       AFTER INSERT ON cvterm
       FOR EACH ROW
       EXECUTE PROCEDURE cvterm_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for cvterm_relationship audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_relationship_audit_insert_tbl;
   CREATE TABLE cvterm_relationship_audit_insert_tbl ( 
       cvterm_relationship_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cvterm_relationship_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvterm_relationship_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cvterm_relationship_id_var integer; 
   BEGIN
       cvterm_relationship_id_var = NEW.cvterm_relationship_id;

       INSERT INTO cvterm_relationship_audit_insert_tbl ( 
             cvterm_relationship_id
       ) VALUES ( 
             cvterm_relationship_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cvterm_relationship_audit_insert_trgr ON cvterm_relationship;
   CREATE TRIGGER cvterm_relationship_audit_insert_trgr
       AFTER INSERT ON cvterm_relationship
       FOR EACH ROW
       EXECUTE PROCEDURE cvterm_relationship_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for cvtermpath audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermpath_audit_insert_tbl;

   CREATE TABLE cvtermpath_audit_insert_tbl ( 
       cvtermpath_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cvtermpath_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvtermpath_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cvtermpath_id_var integer; 
   BEGIN
       cvtermpath_id_var = NEW.cvtermpath_id;

       INSERT INTO cvtermpath_audit_insert_tbl ( 
             cvtermpath_id
       ) VALUES ( 
             cvtermpath_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cvtermpath_audit_insert_trgr ON cvtermpath;
   CREATE TRIGGER cvtermpath_audit_insert_trgr
       AFTER INSERT ON cvtermpath
       FOR EACH ROW
       EXECUTE PROCEDURE cvtermpath_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for cvtermsynonym audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermsynonym_audit_insert_tbl;
   CREATE TABLE cvtermsynonym_audit_insert_tbl ( 
       cvtermsynonym_id integer
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cvtermsynonym_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvtermsynonym_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cvtermsynonym_id_var integer; 
   BEGIN
       cvtermsynonym_id_var = NEW.cvtermsynonym_id;

       INSERT INTO cvtermsynonym_audit_insert_tbl ( 
             cvtermsynonym_id
       ) VALUES ( 
             cvtermsynonym_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cvtermsynonym_audit_insert_trgr ON cvtermsynonym;
   CREATE TRIGGER cvtermsynonym_audit_insert_trgr
       AFTER INSERT ON cvtermsynonym
       FOR EACH ROW
       EXECUTE PROCEDURE cvtermsynonym_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for cvterm_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvterm_dbxref_audit_insert_tbl;

   CREATE TABLE cvterm_dbxref_audit_insert_tbl ( 
       cvterm_dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cvterm_dbxref_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvterm_dbxref_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cvterm_dbxref_id_var integer; 
   BEGIN
       cvterm_dbxref_id_var = NEW.cvterm_dbxref_id;

       INSERT INTO cvterm_dbxref_audit_insert_tbl ( 
             cvterm_dbxref_id 
       ) VALUES ( 
             cvterm_dbxref_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cvterm_dbxref_audit_insert_trgr ON cvterm_dbxref;
   CREATE TRIGGER cvterm_dbxref_audit_insert_trgr
       AFTER INSERT ON cvterm_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE cvterm_dbxref_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for cvtermprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS cvtermprop_audit_insert_tbl;
   CREATE TABLE cvtermprop_audit_insert_tbl ( 
       cvtermprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on cvtermprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION cvtermprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       cvtermprop_id_var integer; 
   BEGIN
       cvtermprop_id_var = NEW.cvtermprop_id;

       INSERT INTO cvtermprop_audit_insert_tbl ( 
             cvtermprop_id
       ) VALUES ( 
             cvtermprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS cvtermprop_audit_insert_trgr ON cvtermprop;
   CREATE TRIGGER cvtermprop_audit_insert_trgr
       AFTER INSERT ON cvtermprop
       FOR EACH ROW
       EXECUTE PROCEDURE cvtermprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for dbxrefprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS dbxrefprop_audit_insert_tbl;
   CREATE TABLE dbxrefprop_audit_insert_tbl ( 
       dbxrefprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on dbxrefprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION dbxrefprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       dbxrefprop_id_var integer; 
   BEGIN
       dbxrefprop_id_var = NEW.dbxrefprop_id;

       INSERT INTO dbxrefprop_audit_insert_tbl ( 
             dbxrefprop_id
       ) VALUES ( 
             dbxrefprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS dbxrefprop_audit_insert_trgr ON dbxrefprop;
   CREATE TRIGGER dbxrefprop_audit_insert_trgr
       AFTER INSERT ON dbxrefprop
       FOR EACH ROW
       EXECUTE PROCEDURE dbxrefprop_audit_insert_proc();

