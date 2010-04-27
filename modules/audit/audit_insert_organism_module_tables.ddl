----------------------------------------------------------------------
--
-- Definitions for organism audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_audit_insert_tbl;
   CREATE TABLE organism_audit_insert_tbl ( 
       organism_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on organism_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION organism_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       organism_id_var integer; 
   BEGIN
       organism_id_var = NEW.organism_id;

       INSERT INTO organism_audit_insert_tbl ( 
             organism_id
       ) VALUES ( 
             organism_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS organism_audit_insert_trgr ON organism;
   CREATE TRIGGER organism_audit_insert_trgr
       AFTER INSERT ON organism
       FOR EACH ROW
       EXECUTE PROCEDURE organism_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for organism_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_dbxref_audit_insert_tbl;
   CREATE TABLE organism_dbxref_audit_insert_tbl ( 
       organism_dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on organism_dbxref_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION organism_dbxref_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       organism_dbxref_id_var integer; 
   BEGIN
       organism_dbxref_id_var = NEW.organism_dbxref_id;

       INSERT INTO organism_dbxref_audit_insert_tbl ( 
             organism_dbxref_id
       ) VALUES ( 
             organism_dbxref_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS organism_dbxref_audit_insert_trgr ON organism_dbxref;
   CREATE TRIGGER organism_dbxref_audit_insert_trgr
       AFTER INSERT ON organism_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE organism_dbxref_audit_insert_proc ();

----------------------------------------------------------------------
--
-- Definitions for organismprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organismprop_audit_insert_tbl;
   CREATE TABLE organismprop_audit_insert_tbl ( 
       organismprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on organismprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION organismprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       organismprop_id_var integer; 
   BEGIN
       organismprop_id_var = NEW.organismprop_id;

       INSERT INTO organismprop_audit_insert_tbl ( 
             organismprop_id
       ) VALUES ( 
             organismprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS organismprop_audit_insert_trgr ON organismprop;
   CREATE TRIGGER organismprop_audit_insert_trgr
       AFTER INSERT ON organismprop
       FOR EACH ROW
       EXECUTE PROCEDURE organismprop_audit_insert_proc();
