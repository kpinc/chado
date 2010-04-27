----------------------------------------------------------------------
--
-- Definitions for pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_audit_insert_tbl;
   CREATE TABLE pub_audit_insert_tbl ( 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       pub_id_var integer; 
   BEGIN
       pub_id_var = NEW.pub_id;

       INSERT INTO pub_audit_insert_tbl ( 
             pub_id
       ) VALUES ( 
             pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS pub_audit_insert_trgr ON pub;
   CREATE TRIGGER pub_audit_insert_trgr
       AFTER INSERT ON pub
       FOR EACH ROW
       EXECUTE PROCEDURE pub_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for pub_relationship audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_relationship_audit_insert_tbl;
   CREATE TABLE pub_relationship_audit_insert_tbl ( 
       pub_relationship_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on pub_relationship_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pub_relationship_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       pub_relationship_id_var integer; 
   BEGIN
       pub_relationship_id_var = NEW.pub_relationship_id;

       INSERT INTO pub_relationship_audit_insert_tbl ( 
             pub_relationship_id
       ) VALUES ( 
             pub_relationship_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS pub_relationship_audit_insert_trgr ON pub_relationship;
   CREATE TRIGGER pub_relationship_audit_insert_trgr
       AFTER INSERT ON pub_relationship
       FOR EACH ROW
       EXECUTE PROCEDURE pub_relationship_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for pub_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_dbxref_audit_insert_tbl;
   CREATE TABLE pub_dbxref_audit_insert_tbl ( 
       pub_dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on pub_dbxref_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pub_dbxref_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       pub_dbxref_id_var integer; 
   BEGIN
       pub_dbxref_id_var = NEW.pub_dbxref_id;

       INSERT INTO pub_dbxref_audit_insert_tbl ( 
             pub_dbxref_id
       ) VALUES ( 
             pub_dbxref_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS pub_dbxref_audit_insert_trgr ON pub_dbxref;
   CREATE TRIGGER pub_dbxref_audit_insert_trgr
       AFTER INSERT ON pub_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE pub_dbxref_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for pubauthor audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubauthor_audit_insert_tbl;
   CREATE TABLE pubauthor_audit_insert_tbl ( 
       pubauthor_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on pubauthor_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pubauthor_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       pubauthor_id_var integer; 
   BEGIN
       pubauthor_id_var = NEW.pubauthor_id;

       INSERT INTO pubauthor_audit_insert_tbl ( 
             pubauthor_id
       ) VALUES ( 
             pubauthor_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS pubauthor_audit_insert_trgr ON pubauthor;
   CREATE TRIGGER pubauthor_audit_insert_trgr
       AFTER INSERT ON pubauthor
       FOR EACH ROW
       EXECUTE PROCEDURE pubauthor_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for pubprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubprop_audit_insert_tbl;
   CREATE TABLE pubprop_audit_insert_tbl ( 
       pubprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on pubprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pubprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       pubprop_id_var integer; 
   BEGIN
       pubprop_id_var = NEW.pubprop_id;

       INSERT INTO pubprop_audit_insert_tbl ( 
             pubprop_id
       ) VALUES ( 
             pubprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS pubprop_audit_insert_trgr ON pubprop;
   CREATE TRIGGER pubprop_audit_insert_trgr
       AFTER INSERT ON pubprop
       FOR EACH ROW
       EXECUTE PROCEDURE pubprop_audit_insert_proc();
