----------------------------------------------------------------------
--
-- Definitions for feature audit insert table
--
----------------------------------------------------------------------
   DROP TABLE IF EXISTS feature_audit_insert_tbl;
   CREATE TABLE feature_audit_insert_tbl ( 
       feature_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_id_var integer; 
   BEGIN
       feature_id_var = NEW.feature_id;

       INSERT INTO feature_audit_insert_tbl ( 
             feature_id
       ) VALUES ( 
             feature_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_audit_insert_trgr ON feature;
   CREATE TRIGGER feature_audit_insert_trgr
       AFTER INSERT ON feature
       FOR EACH ROW
       EXECUTE PROCEDURE feature_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for featureloc audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_audit_insert_tbl;
   CREATE TABLE featureloc_audit_insert_tbl ( 
       featureloc_id integer,
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on featureloc_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureloc_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       featureloc_id_var integer; 
   BEGIN
       featureloc_id_var = NEW.featureloc_id;

       INSERT INTO featureloc_audit_insert_tbl ( 
             featureloc_id
       ) VALUES ( 
             featureloc_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS featureloc_audit_insert_trgr ON featureloc;
   CREATE TRIGGER featureloc_audit_insert_trgr
       AFTER INSERT ON featureloc
       FOR EACH ROW
       EXECUTE PROCEDURE featureloc_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for featureloc_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_pub_audit_insert_tbl;
   CREATE TABLE featureloc_pub_audit_insert_tbl ( 
       featureloc_pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on featureloc_pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureloc_pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       featureloc_pub_id_var integer; 
   BEGIN
       featureloc_pub_id_var = NEW.featureloc_pub_id;

       INSERT INTO featureloc_pub_audit_insert_tbl ( 
             featureloc_pub_id
       ) VALUES ( 
             featureloc_pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS featureloc_pub_audit_insert_trgr ON featureloc_pub;
   CREATE TRIGGER featureloc_pub_audit_insert_trgr
       AFTER INSERT ON featureloc_pub
       FOR EACH ROW
       EXECUTE PROCEDURE featureloc_pub_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pub_audit_insert_tbl;
   CREATE TABLE feature_pub_audit_insert_tbl ( 
       feature_pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_pub_id_var integer; 
   BEGIN
       feature_pub_id_var = NEW.feature_pub_id;

       INSERT INTO feature_pub_audit_insert_tbl ( 
             feature_pub_id
       ) VALUES ( 
             feature_pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_pub_audit_insert_trgr ON feature_pub;
   CREATE TRIGGER feature_pub_audit_insert_trgr
       AFTER INSERT ON feature_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_pub_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_pubprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pubprop_audit_insert_tbl;
   CREATE TABLE feature_pubprop_audit_insert_tbl ( 
       feature_pubprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_pubprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_pubprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_pubprop_id_var integer; 
   BEGIN
       feature_pubprop_id_var = NEW.feature_pubprop_id;

       INSERT INTO feature_pubprop_audit_insert_tbl ( 
             feature_pubprop_id
       ) VALUES ( 
             feature_pubprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_pubprop_audit_insert_trgr ON feature_pubprop;
   CREATE TRIGGER feature_pubprop_audit_insert_trgr
       AFTER INSERT ON feature_pubprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_pubprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for featureprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_audit_insert_tbl;
   CREATE TABLE featureprop_audit_insert_tbl ( 
       featureprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on featureprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       featureprop_id_var integer; 
   BEGIN
       featureprop_id_var = NEW.featureprop_id;

       INSERT INTO featureprop_audit_insert_tbl ( 
             featureprop_id
       ) VALUES ( 
             featureprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS featureprop_audit_insert_trgr ON featureprop;
   CREATE TRIGGER featureprop_audit_insert_trgr
       AFTER INSERT ON featureprop
       FOR EACH ROW
       EXECUTE PROCEDURE featureprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for featureprop_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_pub_audit_insert_tbl;
   CREATE TABLE featureprop_pub_audit_insert_tbl ( 
       featureprop_pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on featureprop_pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureprop_pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       featureprop_pub_id_var integer; 
   BEGIN
       featureprop_pub_id_var = NEW.featureprop_pub_id;

       INSERT INTO featureprop_pub_audit_insert_tbl ( 
             featureprop_pub_id
       ) VALUES ( 
             featureprop_pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS featureprop_pub_audit_insert_trgr ON featureprop_pub;
   CREATE TRIGGER featureprop_pub_audit_insert_trgr
       AFTER INSERT ON featureprop_pub
       FOR EACH ROW
       EXECUTE PROCEDURE featureprop_pub_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxref_audit_insert_tbl;
   CREATE TABLE feature_dbxref_audit_insert_tbl ( 
       feature_dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_dbxref_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_dbxref_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_dbxref_id_var integer; 
   BEGIN
       feature_dbxref_id_var = NEW.feature_dbxref_id;

       INSERT INTO feature_dbxref_audit_insert_tbl ( 
             feature_dbxref_id
       ) VALUES ( 
             feature_dbxref_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_dbxref_audit_insert_trgr ON feature_dbxref;
   CREATE TRIGGER feature_dbxref_audit_insert_trgr
       AFTER INSERT ON feature_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE feature_dbxref_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_dbxrefprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxrefprop_audit_insert_tbl;
   CREATE TABLE feature_dbxrefprop_audit_insert_tbl ( 
       feature_dbxrefprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_dbxrefprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_dbxrefprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_dbxrefprop_id_var integer; 
   BEGIN
       feature_dbxrefprop_id_var = NEW.feature_dbxrefprop_id;

       INSERT INTO feature_dbxrefprop_audit_insert_tbl ( 
             feature_dbxrefprop_id
       ) VALUES ( 
             feature_dbxrefprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_dbxrefprop_audit_insert_trgr ON feature_dbxrefprop;
   CREATE TRIGGER feature_dbxrefprop_audit_insert_trgr
       AFTER INSERT ON feature_dbxrefprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_dbxrefprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relationship audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_audit_insert_tbl;
   CREATE TABLE feature_relationship_audit_insert_tbl ( 
       feature_relationship_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_relationship_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationship_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationship_id_var integer; 
   BEGIN
       feature_relationship_id_var = NEW.feature_relationship_id;

       INSERT INTO feature_relationship_audit_insert_tbl ( 
             feature_relationship_id
       ) VALUES ( 
             feature_relationship_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_relationship_audit_insert_trgr ON feature_relationship;
   CREATE TRIGGER feature_relationship_audit_insert_trgr
       AFTER INSERT ON feature_relationship
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationship_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relationship_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_pub_audit_insert_tbl;
   CREATE TABLE feature_relationship_pub_audit_insert_tbl ( 
       feature_relationship_pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_relationship_pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationship_pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationship_pub_id_var integer; 
   BEGIN
       feature_relationship_pub_id_var = NEW.feature_relationship_pub_id;

       INSERT INTO feature_relationship_pub_audit_insert_tbl ( 
             feature_relationship_pub_id
       ) VALUES ( 
             feature_relationship_pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_relationship_pub_audit_insert_trgr ON feature_relationship_pub;
   CREATE TRIGGER feature_relationship_pub_audit_insert_trgr
       AFTER INSERT ON feature_relationship_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationship_pub_audit_insert_trgr ();

----------------------------------------------------------------------
--
-- Definitions for feature_relationshipprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_audit_insert_tbl;
   CREATE TABLE feature_relationshipprop_audit_insert_tbl ( 
       feature_relationshipprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_relationshipprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationshipprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationshipprop_id_var integer; 
   BEGIN
       feature_relationshipprop_id_var = NEW.feature_relationshipprop_id;

       INSERT INTO feature_relationshipprop_audit_insert_tbl ( 
             feature_relationshipprop_id
       ) VALUES ( 
             feature_relationshipprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_relationshipprop_audit_insert_trgr ON feature_relationshipprop;
   CREATE TRIGGER feature_relationshipprop_audit_insert_trgr
       AFTER INSERT ON feature_relationshipprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationshipprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relationshipprop_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_pub_audit_insert_tbl;
   CREATE TABLE feature_relationshipprop_pub_audit_insert_tbl ( 
       feature_relationshipprop_pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_relationshipprop_pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationshipprop_pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationshipprop_pub_id_var integer; 
   BEGIN
       feature_relationshipprop_pub_id_var = NEW.feature_relationshipprop_pub_id;

       INSERT INTO feature_relationshipprop_pub_audit_insert_tbl ( 
             feature_relationshipprop_pub_id
       ) VALUES ( 
             feature_relationshipprop_pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_relationshipprop_pub_audit_insert_trgr ON feature_relationshipprop_pub;
   CREATE TRIGGER feature_relationshipprop_pub_audit_insert_trgr
       AFTER INSERT ON feature_relationshipprop_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationshipprop_pub_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_audit_insert_tbl;
   CREATE TABLE feature_cvterm_audit_insert_tbl ( 
       feature_cvterm_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_cvterm_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvterm_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvterm_id_var integer; 
   BEGIN
       feature_cvterm_id_var = NEW.feature_cvterm_id;

       INSERT INTO feature_cvterm_audit_insert_tbl ( 
             feature_cvterm_id
       ) VALUES ( 
             feature_cvterm_id_var 
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_cvterm_audit_insert_trgr ON feature_cvterm;
   CREATE TRIGGER feature_cvterm_audit_insert_trgr
       AFTER INSERT ON feature_cvterm
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvterm_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvtermprop audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvtermprop_audit_insert_tbl;
   CREATE TABLE feature_cvtermprop_audit_insert_tbl ( 
       feature_cvtermprop_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_cvtermprop_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvtermprop_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvtermprop_id_var integer; 
   BEGIN
       feature_cvtermprop_id_var = NEW.feature_cvtermprop_id;

       INSERT INTO feature_cvtermprop_audit_insert_tbl ( 
             feature_cvtermprop_id
       ) VALUES ( 
             feature_cvtermprop_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_cvtermprop_audit_insert_trgr ON feature_cvtermprop;
   CREATE TRIGGER feature_cvtermprop_audit_insert_trgr
       AFTER INSERT ON feature_cvtermprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvtermprop_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_dbxref audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_dbxref_audit_insert_tbl;
   CREATE TABLE feature_cvterm_dbxref_audit_insert_tbl ( 
       feature_cvterm_dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_cvterm_dbxref_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvterm_dbxref_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvterm_dbxref_id_var integer; 
   BEGIN
       feature_cvterm_dbxref_id_var = NEW.feature_cvterm_dbxref_id;

       INSERT INTO feature_cvterm_dbxref_audit_insert_tbl ( 
             feature_cvterm_dbxref_id
       ) VALUES ( 
             feature_cvterm_dbxref_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_cvterm_dbxref_audit_insert_trgr ON feature_cvterm_dbxref;
   CREATE TRIGGER feature_cvterm_dbxref_audit_insert_trgr
       AFTER INSERT ON feature_cvterm_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvterm_dbxref_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_pub audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_pub_audit_insert_tbl;
   CREATE TABLE feature_cvterm_pub_audit_insert_tbl ( 
       feature_cvterm_pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_cvterm_pub_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvterm_pub_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvterm_pub_id_var integer; 
   BEGIN
       feature_cvterm_pub_id_var = NEW.feature_cvterm_pub_id;

       INSERT INTO feature_cvterm_pub_audit_insert_tbl ( 
             feature_cvterm_pub_id
       ) VALUES ( 
             feature_cvterm_pub_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_cvterm_pub_audit_insert_trgr ON feature_cvterm_pub;
   CREATE TRIGGER feature_cvterm_pub_audit_insert_trgr
       AFTER INSERT ON feature_cvterm_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvterm_pub_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for synonym audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS synonym_audit_insert_tbl;
   CREATE TABLE synonym_audit_insert_tbl ( 
       synonym_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on synonym_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION synonym_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       synonym_id_var integer; 
   BEGIN
       synonym_id_var = NEW.synonym_id;

       INSERT INTO synonym_audit_insert_tbl ( 
             synonym_id
       ) VALUES ( 
             synonym_id_var 
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS synonym_audit_insert_trgr ON synonym;
   CREATE TRIGGER synonym_audit_insert_trgr
       AFTER INSERT ON synonym
       FOR EACH ROW
       EXECUTE PROCEDURE synonym_audit_insert_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_synonym audit insert table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_synonym_audit_insert_tbl;
   CREATE TABLE feature_synonym_audit_insert_tbl ( 
       feature_synonym_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now()
   );
   GRANT ALL on feature_synonym_audit_insert_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_synonym_audit_insert_proc() RETURNS trigger AS
   '
   DECLARE
       feature_synonym_id_var integer; 
   BEGIN
       feature_synonym_id_var = NEW.feature_synonym_id;

       INSERT INTO feature_synonym_audit_insert_tbl ( 
             feature_synonym_id
       ) VALUES ( 
             feature_synonym_id_var
       );

       return NEW;
   END
   '
   LANGUAGE plpgsql; 

   DROP TRIGGER IF EXISTS feature_synonym_audit_insert_trgr ON feature_synonym;
   CREATE TRIGGER feature_synonym_audit_insert_trgr
       AFTER INSERT ON feature_synonym
       FOR EACH ROW
       EXECUTE PROCEDURE feature_synonym_audit_insert_proc();

