----------------------------------------------------------------------
--
-- Definitions for feature update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_audit_ud_tbl;
   CREATE TABLE feature_audit_ud_tbl ( 
       feature_id integer, 
       dbxref_id integer, 
       organism_id integer, 
       name varchar(255), 
       uniquename text, 
       residues text, 
       seqlen integer, 
       md5checksum char(32), 
       type_id integer, 
       is_analysis boolean, 
       is_obsolete boolean, 
       timeaccessioned timestamp, 
       timelastmodified timestamp, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_id_var integer; 
       dbxref_id_var integer; 
       organism_id_var integer; 
       name_var varchar(255); 
       uniquename_var text; 
       residues_var text; 
       seqlen_var integer; 
       md5checksum_var char(32); 
       type_id_var integer; 
       is_analysis_var boolean; 
       is_obsolete_var boolean; 
       timeaccessioned_var timestamp; 
       timelastmodified_var timestamp; 
       
       transaction_type_var char;
   BEGIN
       feature_id_var = OLD.feature_id;
       dbxref_id_var = OLD.dbxref_id;
       organism_id_var = OLD.organism_id;
       name_var = OLD.name;
       uniquename_var = OLD.uniquename;
       residues_var = OLD.residues;
       seqlen_var = OLD.seqlen;
       md5checksum_var = OLD.md5checksum;
       type_id_var = OLD.type_id;
       is_analysis_var = OLD.is_analysis;
       is_obsolete_var = OLD.is_obsolete;
       timeaccessioned_var = OLD.timeaccessioned;
       timelastmodified_var = OLD.timelastmodified;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_audit_ud_tbl ( 
             feature_id, 
             dbxref_id, 
             organism_id, 
             name, 
             uniquename, 
             residues, 
             seqlen, 
             md5checksum, 
             type_id, 
             is_analysis, 
             is_obsolete, 
             timeaccessioned, 
             timelastmodified, 
             transaction_type
       ) VALUES ( 
             feature_id_var, 
             dbxref_id_var, 
             organism_id_var, 
             name_var, 
             uniquename_var, 
             residues_var, 
             seqlen_var, 
             md5checksum_var, 
             type_id_var, 
             is_analysis_var, 
             is_obsolete_var, 
             timeaccessioned_var, 
             timelastmodified_var, 
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

   DROP TRIGGER IF EXISTS feature_audit_ud_trgr ON feature;
   CREATE TRIGGER feature_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature
       FOR EACH ROW
       EXECUTE PROCEDURE feature_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for featureloc update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_audit_ud_tbl;
   CREATE TABLE featureloc_audit_ud_tbl ( 
       featureloc_id integer, 
       feature_id integer, 
       srcfeature_id integer, 
       fmin integer, 
       is_fmin_partial boolean, 
       fmax integer, 
       is_fmax_partial boolean, 
       strand integer, 
       phase integer, 
       residue_info text, 
       locgroup integer, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on featureloc_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureloc_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       featureloc_id_var integer; 
       feature_id_var integer; 
       srcfeature_id_var integer; 
       fmin_var integer; 
       is_fmin_partial_var boolean; 
       fmax_var integer; 
       is_fmax_partial_var boolean; 
       strand_var integer; 
       phase_var integer; 
       residue_info_var text; 
       locgroup_var integer; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       featureloc_id_var = OLD.featureloc_id;
       feature_id_var = OLD.feature_id;
       srcfeature_id_var = OLD.srcfeature_id;
       fmin_var = OLD.fmin;
       is_fmin_partial_var = OLD.is_fmin_partial;
       fmax_var = OLD.fmax;
       is_fmax_partial_var = OLD.is_fmax_partial;
       strand_var = OLD.strand;
       phase_var = OLD.phase;
       residue_info_var = OLD.residue_info;
       locgroup_var = OLD.locgroup;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO featureloc_audit_ud_tbl ( 
             featureloc_id, 
             feature_id, 
             srcfeature_id, 
             fmin, 
             is_fmin_partial, 
             fmax, 
             is_fmax_partial, 
             strand, 
             phase, 
             residue_info, 
             locgroup, 
             rank, 
             transaction_type
       ) VALUES ( 
             featureloc_id_var, 
             feature_id_var, 
             srcfeature_id_var, 
             fmin_var, 
             is_fmin_partial_var, 
             fmax_var, 
             is_fmax_partial_var, 
             strand_var, 
             phase_var, 
             residue_info_var, 
             locgroup_var, 
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

   DROP TRIGGER IF EXISTS featureloc_audit_ud_trgr ON featureloc;
   CREATE TRIGGER featureloc_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON featureloc
       FOR EACH ROW
       EXECUTE PROCEDURE featureloc_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for featureloc_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureloc_pub_audit_ud_tbl;
   CREATE TABLE featureloc_pub_audit_ud_tbl ( 
       featureloc_pub_id integer, 
       featureloc_id integer, 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on featureloc_pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureloc_pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       featureloc_pub_id_var integer; 
       featureloc_id_var integer; 
       pub_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       featureloc_pub_id_var = OLD.featureloc_pub_id;
       featureloc_id_var = OLD.featureloc_id;
       pub_id_var = OLD.pub_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO featureloc_pub_audit_ud_tbl ( 
             featureloc_pub_id, 
             featureloc_id, 
             pub_id, 
             transaction_type
       ) VALUES ( 
             featureloc_pub_id_var, 
             featureloc_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS featureloc_pub_audit_ud_trgr ON featureloc_pub;
   CREATE TRIGGER featureloc_pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON featureloc_pub
       FOR EACH ROW
       EXECUTE PROCEDURE featureloc_pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pub_audit_ud_tbl;
   CREATE TABLE feature_pub_audit_ud_tbl ( 
       feature_pub_id integer, 
       feature_id integer, 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_pub_id_var integer; 
       feature_id_var integer; 
       pub_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_pub_id_var = OLD.feature_pub_id;
       feature_id_var = OLD.feature_id;
       pub_id_var = OLD.pub_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_pub_audit_ud_tbl ( 
             feature_pub_id, 
             feature_id, 
             pub_id, 
             transaction_type
       ) VALUES ( 
             feature_pub_id_var, 
             feature_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS feature_pub_audit_ud_trgr ON feature_pub;
   CREATE TRIGGER feature_pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_pubprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_pubprop_audit_ud_tbl;
   CREATE TABLE feature_pubprop_audit_ud_tbl ( 
       feature_pubprop_id integer, 
       feature_pub_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_pubprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_pubprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_pubprop_id_var integer; 
       feature_pub_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_pubprop_id_var = OLD.feature_pubprop_id;
       feature_pub_id_var = OLD.feature_pub_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_pubprop_audit_ud_tbl ( 
             feature_pubprop_id, 
             feature_pub_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             feature_pubprop_id_var, 
             feature_pub_id_var, 
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

   DROP TRIGGER IF EXISTS feature_pubprop_audit_ud_trgr ON feature_pubprop;
   CREATE TRIGGER feature_pubprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_pubprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_pubprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for featureprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_audit_ud_tbl;
   CREATE TABLE featureprop_audit_ud_tbl ( 
       featureprop_id integer, 
       feature_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on featureprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       featureprop_id_var integer; 
       feature_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       featureprop_id_var = OLD.featureprop_id;
       feature_id_var = OLD.feature_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO featureprop_audit_ud_tbl ( 
             featureprop_id, 
             feature_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             featureprop_id_var, 
             feature_id_var, 
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

   DROP TRIGGER IF EXISTS featureprop_audit_ud_trgr ON featureprop;
   CREATE TRIGGER featureprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON featureprop
       FOR EACH ROW
       EXECUTE PROCEDURE featureprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for featureprop_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS featureprop_pub_audit_ud_tbl;
   CREATE TABLE featureprop_pub_audit_ud_tbl ( 
       featureprop_pub_id integer, 
       featureprop_id integer, 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on featureprop_pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION featureprop_pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       featureprop_pub_id_var integer; 
       featureprop_id_var integer; 
       pub_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       featureprop_pub_id_var = OLD.featureprop_pub_id;
       featureprop_id_var = OLD.featureprop_id;
       pub_id_var = OLD.pub_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO featureprop_pub_audit_ud_tbl ( 
             featureprop_pub_id, 
             featureprop_id, 
             pub_id, 
             transaction_type
       ) VALUES ( 
             featureprop_pub_id_var, 
             featureprop_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS featureprop_pub_audit_ud_trgr ON featureprop_pub;
   CREATE TRIGGER featureprop_pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON featureprop_pub
       FOR EACH ROW
       EXECUTE PROCEDURE featureprop_pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxref_audit_ud_tbl;
   CREATE TABLE feature_dbxref_audit_ud_tbl ( 
       feature_dbxref_id integer, 
       feature_id integer, 
       dbxref_id integer, 
       is_current boolean, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_dbxref_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_dbxref_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_dbxref_id_var integer; 
       feature_id_var integer; 
       dbxref_id_var integer; 
       is_current_var boolean; 
       
       transaction_type_var char;
   BEGIN
       feature_dbxref_id_var = OLD.feature_dbxref_id;
       feature_id_var = OLD.feature_id;
       dbxref_id_var = OLD.dbxref_id;
       is_current_var = OLD.is_current;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_dbxref_audit_ud_tbl ( 
             feature_dbxref_id, 
             feature_id, 
             dbxref_id, 
             is_current, 
             transaction_type
       ) VALUES ( 
             feature_dbxref_id_var, 
             feature_id_var, 
             dbxref_id_var, 
             is_current_var, 
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

   DROP TRIGGER IF EXISTS feature_dbxref_audit_ud_trgr ON feature_dbxref;
   CREATE TRIGGER feature_dbxref_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE feature_dbxref_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_dbxrefprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_dbxrefprop_audit_ud_tbl;
   CREATE TABLE feature_dbxrefprop_audit_ud_tbl ( 
       feature_dbxrefprop_id integer, 
       feature_dbxref_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_dbxrefprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_dbxrefprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_dbxrefprop_id_var integer; 
       feature_dbxref_id_var integer; 
       type_id_var integer; 
       value_var text;
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_dbxrefprop_id_var = OLD.feature_dbxrefprop_id;
       feature_dbxref_id_var = OLD.feature_dbxref_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_dbxrefprop_audit_ud_tbl ( 
             feature_dbxrefprop_id, 
             feature_dbxref_id, 
             type_id, 
             value, 
             rank,
             transaction_type
       ) VALUES ( 
             feature_dbxrefprop_id_var, 
             feature_dbxref_id_var, 
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

   DROP TRIGGER IF EXISTS feature_dbxrefprop_audit_ud_trgr ON feature_dbxrefprop;
   CREATE TRIGGER feature_dbxrefprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_dbxrefprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_dbxrefprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relationship update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_audit_ud_tbl;
   CREATE TABLE feature_relationship_audit_ud_tbl ( 
       feature_relationship_id integer, 
       subject_id integer, 
       object_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_relationship_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationship_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationship_id_var integer; 
       subject_id_var integer; 
       object_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_relationship_id_var = OLD.feature_relationship_id;
       subject_id_var = OLD.subject_id;
       object_id_var = OLD.object_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_relationship_audit_ud_tbl ( 
             feature_relationship_id, 
             subject_id, 
             object_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             feature_relationship_id_var, 
             subject_id_var, 
             object_id_var, 
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

   DROP TRIGGER IF EXISTS feature_relationship_audit_ud_trgr ON feature_relationship;
   CREATE TRIGGER feature_relationship_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_relationship
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationship_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relationship_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationship_pub_audit_ud_tbl;
   CREATE TABLE feature_relationship_pub_audit_ud_tbl ( 
       feature_relationship_pub_id integer, 
       feature_relationship_id integer, 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_relationship_pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationship_pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationship_pub_id_var integer; 
       feature_relationship_id_var integer; 
       pub_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_relationship_pub_id_var = OLD.feature_relationship_pub_id;
       feature_relationship_id_var = OLD.feature_relationship_id;
       pub_id_var = OLD.pub_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_relationship_pub_audit_ud_tbl ( 
             feature_relationship_pub_id, 
             feature_relationship_id, 
             pub_id, 
             transaction_type
       ) VALUES ( 
             feature_relationship_pub_id_var, 
             feature_relationship_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS feature_relationship_pub_audit_ud_trgr ON feature_relationship_pub;
   CREATE TRIGGER feature_relationship_pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_relationship_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationship_pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relatonshipprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_audit_ud_tbl;
   CREATE TABLE feature_relationshipprop_audit_ud_tbl ( 
       feature_relationshipprop_id integer, 
       feature_relationship_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_relationshipprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationshipprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationshipprop_id_var integer; 
       feature_relationship_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_relationshipprop_id_var = OLD.feature_relationshipprop_id;
       feature_relationship_id_var = OLD.feature_relationship_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_relationshipprop_audit_ud_tbl ( 
             feature_relationshipprop_id, 
             feature_relationship_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             feature_relationshipprop_id_var, 
             feature_relationship_id_var, 
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

   DROP TRIGGER IF EXISTS feature_relationshipprop_audit_ud_trgr ON feature_relationshipprop;
   CREATE TRIGGER feature_relationshipprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_relationshipprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationshipprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_relationshipprop_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_relationshipprop_pub_audit_ud_tbl;
   CREATE TABLE feature_relationshipprop_pub_audit_ud_tbl ( 
       feature_relationshipprop_pub_id integer, 
       feature_relationshipprop_id integer, 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_relationshipprop_pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_relationshipprop_pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_relationshipprop_pub_id_var integer; 
       feature_relationshipprop_id_var integer; 
       pub_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_relationshipprop_pub_id_var = OLD.feature_relationshipprop_pub_id;
       feature_relationshipprop_id_var = OLD.feature_relationshipprop_id;
       pub_id_var = OLD.pub_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_relationshipprop_pub_audit_ud_tbl ( 
             feature_relationshipprop_pub_id, 
             feature_relationshipprop_id, 
             pub_id, 
             transaction_type
       ) VALUES ( 
             feature_relationshipprop_pub_id_var, 
             feature_relationshipprop_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS feature_relationshipprop_pub_audit_ud_trgr ON feature_relationshipprop_pub;
   CREATE TRIGGER feature_relationshipprop_pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_relationshipprop_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_relationshipprop_pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_audit_ud_tbl;
   CREATE TABLE feature_cvterm_audit_ud_tbl ( 
       feature_cvterm_id integer, 
       feature_id integer, 
       cvterm_id integer, 
       pub_id integer, 
       is_not boolean, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_cvterm_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvterm_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvterm_id_var integer; 
       feature_id_var integer; 
       cvterm_id_var integer; 
       pub_id_var integer; 
       is_not_var boolean; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_cvterm_id_var = OLD.feature_cvterm_id;
       feature_id_var = OLD.feature_id;
       cvterm_id_var = OLD.cvterm_id;
       pub_id_var = OLD.pub_id;
       is_not_var = OLD.is_not;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_cvterm_audit_ud_tbl ( 
             feature_cvterm_id, 
             feature_id, 
             cvterm_id, 
             pub_id, 
             is_not, 
             rank, 
             transaction_type
       ) VALUES ( 
             feature_cvterm_id_var, 
             feature_id_var, 
             cvterm_id_var, 
             pub_id_var, 
             is_not_var, 
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

   DROP TRIGGER IF EXISTS feature_cvterm_audit_ud_trgr ON feature_cvterm;
   CREATE TRIGGER feature_cvterm_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_cvterm
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvterm_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvtermprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvtermprop_audit_ud_tbl;
   CREATE TABLE feature_cvtermprop_audit_ud_tbl ( 
       feature_cvtermprop_id integer, 
       feature_cvterm_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_cvtermprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvtermprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvtermprop_id_var integer; 
       feature_cvterm_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_cvtermprop_id_var = OLD.feature_cvtermprop_id;
       feature_cvterm_id_var = OLD.feature_cvterm_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_cvtermprop_audit_ud_tbl ( 
             feature_cvtermprop_id, 
             feature_cvterm_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             feature_cvtermprop_id_var, 
             feature_cvterm_id_var, 
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

   DROP TRIGGER IF EXISTS feature_cvtermprop_audit_ud_trgr ON feature_cvtermprop;
   CREATE TRIGGER feature_cvtermprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_cvtermprop
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvtermprop_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_dbxref_audit_ud_tbl;
   CREATE TABLE feature_cvterm_dbxref_audit_ud_tbl ( 
       feature_cvterm_dbxref_id integer, 
       feature_cvterm_id integer, 
       dbxref_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_cvterm_dbxref_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvterm_dbxref_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvterm_dbxref_id_var integer; 
       feature_cvterm_id_var integer; 
       dbxref_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_cvterm_dbxref_id_var = OLD.feature_cvterm_dbxref_id;
       feature_cvterm_id_var = OLD.feature_cvterm_id;
       dbxref_id_var = OLD.dbxref_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_cvterm_dbxref_audit_ud_tbl ( 
             feature_cvterm_dbxref_id, 
             feature_cvterm_id, 
             dbxref_id, 
             transaction_type
       ) VALUES ( 
             feature_cvterm_dbxref_id_var, 
             feature_cvterm_id_var, 
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

   DROP TRIGGER IF EXISTS feature_cvterm_dbxref_audit_ud_trgr ON feature_cvterm_dbxref;
   CREATE TRIGGER feature_cvterm_dbxref_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_cvterm_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvterm_dbxref_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_cvterm_pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_cvterm_pub_audit_ud_tbl;
   CREATE TABLE feature_cvterm_pub_audit_ud_tbl ( 
       feature_cvterm_pub_id integer, 
       feature_cvterm_id integer, 
       pub_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_cvterm_pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_cvterm_pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_cvterm_pub_id_var integer; 
       feature_cvterm_id_var integer; 
       pub_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       feature_cvterm_pub_id_var = OLD.feature_cvterm_pub_id;
       feature_cvterm_id_var = OLD.feature_cvterm_id;
       pub_id_var = OLD.pub_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_cvterm_pub_audit_ud_tbl ( 
             feature_cvterm_pub_id, 
             feature_cvterm_id, 
             pub_id, 
             transaction_type
       ) VALUES ( 
             feature_cvterm_pub_id_var, 
             feature_cvterm_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS feature_cvterm_pub_audit_ud_trgr ON feature_cvterm_pub;
   CREATE TRIGGER feature_cvterm_pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_cvterm_pub
       FOR EACH ROW
       EXECUTE PROCEDURE feature_cvterm_pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for synonym update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS synonym_audit_ud_tbl;
   CREATE TABLE synonym_audit_ud_tbl ( 
       synonym_id integer, 
       name varchar(255), 
       type_id integer, 
       synonym_sgml varchar(255), 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on synonym_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION synonym_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       synonym_id_var integer; 
       name_var varchar(255); 
       type_id_var integer; 
       synonym_sgml_var varchar(255); 
       
       transaction_type_var char;
   BEGIN
       synonym_id_var = OLD.synonym_id;
       name_var = OLD.name;
       type_id_var = OLD.type_id;
       synonym_sgml_var = OLD.synonym_sgml;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO synonym_audit_ud_tbl ( 
             synonym_id, 
             name, 
             type_id, 
             synonym_sgml, 
             transaction_type
       ) VALUES ( 
             synonym_id_var, 
             name_var, 
             type_id_var, 
             synonym_sgml_var, 
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

   DROP TRIGGER IF EXISTS synonym_audit_ud_trgr ON synonym;
   CREATE TRIGGER synonym_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON synonym
       FOR EACH ROW
       EXECUTE PROCEDURE synonym_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for feature_synonym update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS feature_synonym_audit_ud_tbl;
   CREATE TABLE feature_synonym_audit_ud_tbl ( 
       feature_synonym_id integer, 
       synonym_id integer, 
       feature_id integer, 
       pub_id integer, 
       is_current boolean, 
       is_internal boolean, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on feature_synonym_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION feature_synonym_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       feature_synonym_id_var integer; 
       synonym_id_var integer; 
       feature_id_var integer; 
       pub_id_var integer; 
       is_current_var boolean; 
       is_internal_var boolean; 
       
       transaction_type_var char;
   BEGIN
       feature_synonym_id_var = OLD.feature_synonym_id;
       synonym_id_var = OLD.synonym_id;
       feature_id_var = OLD.feature_id;
       pub_id_var = OLD.pub_id;
       is_current_var = OLD.is_current;
       is_internal_var = OLD.is_internal;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO feature_synonym_audit_ud_tbl ( 
             feature_synonym_id, 
             synonym_id, 
             feature_id, 
             pub_id, 
             is_current, 
             is_internal, 
             transaction_type
       ) VALUES ( 
             feature_synonym_id_var, 
             synonym_id_var, 
             feature_id_var, 
             pub_id_var, 
             is_current_var, 
             is_internal_var, 
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

   DROP TRIGGER IF EXISTS feature_synonym_audit_ud_trgr ON feature_synonym;
   CREATE TRIGGER feature_synonym_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON feature_synonym
       FOR EACH ROW
       EXECUTE PROCEDURE feature_synonym_audit_update_delete_proc();

