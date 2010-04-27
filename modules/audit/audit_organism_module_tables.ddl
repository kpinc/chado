----------------------------------------------------------------------
--
-- Definitions for organism update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_audit_ud_tbl;
   CREATE TABLE organism_audit_ud_tbl ( 
       organism_id integer, 
       abbreviation varchar(255), 
       genus varchar(255), 
       species varchar(255), 
       common_name varchar(255), 
       comment text, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on organism_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION organism_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       organism_id_var integer; 
       abbreviation_var varchar(255); 
       genus_var varchar(255); 
       species_var varchar(255); 
       common_name_var varchar(255); 
       comment_var text; 
       
       transaction_type_var char;
   BEGIN
       organism_id_var = OLD.organism_id;
       abbreviation_var = OLD.abbreviation;
       genus_var = OLD.genus;
       species_var = OLD.species;
       common_name_var = OLD.common_name;
       comment_var = OLD.comment;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO organism_audit_ud_tbl ( 
             organism_id, 
             abbreviation, 
             genus, 
             species, 
             common_name, 
             comment, 
             transaction_type
       ) VALUES ( 
             organism_id_var, 
             abbreviation_var, 
             genus_var, 
             species_var, 
             common_name_var, 
             comment_var, 
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

   DROP TRIGGER IF EXISTS organism_audit_ud_trgr ON organism;
   CREATE TRIGGER organism_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON organism
       FOR EACH ROW
       EXECUTE PROCEDURE organism_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for organism_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organism_dbxref_audit_ud_tbl;
   CREATE TABLE organism_dbxref_audit_ud_tbl ( 
       organism_dbxref_id integer, 
       organism_id integer, 
       dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on organism_dbxref_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION organism_dbxref_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       organism_dbxref_id_var integer; 
       organism_id_var integer; 
       dbxref_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       organism_dbxref_id_var = OLD.organism_dbxref_id;
       organism_id_var = OLD.organism_id;
       dbxref_id_var = OLD.dbxref_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO organism_dbxref_audit_ud_tbl ( 
             organism_dbxref_id, 
             organism_id, 
             dbxref_id, 
             transaction_type
       ) VALUES ( 
             organism_dbxref_id_var, 
             organism_id_var, 
             dbxref_id_var, 
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

   DROP TRIGGER IF EXISTS organism_dbxref_audit_ud_trgr ON organism_dbxref;
   CREATE TRIGGER organism_dbxref_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON organism_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE organism_dbxref_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for organismprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS organismprop_audit_ud_tbl;
   CREATE TABLE organismprop_audit_ud_tbl ( 
       organismprop_id integer, 
       organism_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on organismprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION organismprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       organismprop_id_var integer; 
       organism_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       organismprop_id_var = OLD.organismprop_id;
       organism_id_var = OLD.organism_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO organismprop_audit_ud_tbl ( 
             organismprop_id, 
             organism_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             organismprop_id_var, 
             organism_id_var, 
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

   DROP TRIGGER IF EXISTS organismprop_audit_ud_trgr ON organismprop;
   CREATE TRIGGER organismprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON organismprop
       FOR EACH ROW
       EXECUTE PROCEDURE organismprop_audit_update_delete_proc();
