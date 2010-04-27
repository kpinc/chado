----------------------------------------------------------------------
--
-- Definitions for pub update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_audit_ud_tbl;
   CREATE TABLE pub_audit_ud_tbl ( 
       pub_id integer, 
       title text, 
       volumetitle text, 
       volume varchar(255), 
       series_name varchar(255), 
       issue varchar(255), 
       pyear varchar(255), 
       pages varchar(255), 
       miniref varchar(255), 
       uniquename text, 
       type_id integer, 
       is_obsolete boolean, 
       publisher varchar(255), 
       pubplace varchar(255), 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on pub_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pub_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       pub_id_var integer; 
       title_var text; 
       volumetitle_var text; 
       volume_var varchar(255); 
       series_name_var varchar(255); 
       issue_var varchar(255); 
       pyear_var varchar(255); 
       pages_var varchar(255); 
       miniref_var varchar(255); 
       uniquename_var text; 
       type_id_var integer; 
       is_obsolete_var boolean; 
       publisher_var varchar(255); 
       pubplace_var varchar(255); 
       
       transaction_type_var char;
   BEGIN
       pub_id_var = OLD.pub_id;
       title_var = OLD.title;
       volumetitle_var = OLD.volumetitle;
       volume_var = OLD.volume;
       series_name_var = OLD.series_name;
       issue_var = OLD.issue;
       pyear_var = OLD.pyear;
       pages_var = OLD.pages;
       miniref_var = OLD.miniref;
       uniquename_var = OLD.uniquename;
       type_id_var = OLD.type_id;
       is_obsolete_var = OLD.is_obsolete;
       publisher_var = OLD.publisher;
       pubplace_var = OLD.pubplace;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO pub_audit_ud_tbl ( 
             pub_id, 
             title, 
             volumetitle, 
             volume, 
             series_name, 
             issue, 
             pyear, 
             pages, 
             miniref, 
             uniquename, 
             type_id, 
             is_obsolete, 
             publisher, 
             pubplace, 
             transaction_type
       ) VALUES ( 
             pub_id_var, 
             title_var, 
             volumetitle_var, 
             volume_var, 
             series_name_var, 
             issue_var, 
             pyear_var, 
             pages_var, 
             miniref_var, 
             uniquename_var, 
             type_id_var, 
             is_obsolete_var, 
             publisher_var, 
             pubplace_var, 
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

   DROP TRIGGER IF EXISTS pub_audit_ud_trgr ON pub;
   CREATE TRIGGER pub_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON pub
       FOR EACH ROW
       EXECUTE PROCEDURE pub_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for pub_relationship update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_relationship_audit_ud_tbl;
   CREATE TABLE pub_relationship_audit_ud_tbl ( 
       pub_relationship_id integer, 
       subject_id integer, 
       object_id integer, 
       type_id integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on pub_relationship_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pub_relationship_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       pub_relationship_id_var integer; 
       subject_id_var integer; 
       object_id_var integer; 
       type_id_var integer; 
       
       transaction_type_var char;
   BEGIN
       pub_relationship_id_var = OLD.pub_relationship_id;
       subject_id_var = OLD.subject_id;
       object_id_var = OLD.object_id;
       type_id_var = OLD.type_id;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO pub_relationship_audit_ud_tbl ( 
             pub_relationship_id, 
             subject_id, 
             object_id, 
             type_id, 
             transaction_type
       ) VALUES ( 
             pub_relationship_id_var, 
             subject_id_var, 
             object_id_var, 
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

   DROP TRIGGER IF EXISTS pub_relationship_audit_ud_trgr ON pub_relationship;
   CREATE TRIGGER pub_relationship_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON pub_relationship
       FOR EACH ROW
       EXECUTE PROCEDURE pub_relationship_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for pub_dbxref update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pub_dbxref_audit_ud_tbl;
   CREATE TABLE pub_dbxref_audit_ud_tbl ( 
       pub_dbxref_id integer, 
       pub_id integer, 
       dbxref_id integer, 
       is_current boolean, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on pub_dbxref_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pub_dbxref_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       pub_dbxref_id_var integer; 
       pub_id_var integer; 
       dbxref_id_var integer; 
       is_current_var boolean; 
       
       transaction_type_var char;
   BEGIN
       pub_dbxref_id_var = OLD.pub_dbxref_id;
       pub_id_var = OLD.pub_id;
       dbxref_id_var = OLD.dbxref_id;
       is_current_var = OLD.is_current;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO pub_dbxref_audit_ud_tbl ( 
             pub_dbxref_id, 
             pub_id, 
             dbxref_id, 
             is_current, 
             transaction_type
       ) VALUES ( 
             pub_dbxref_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS pub_dbxref_audit_ud_trgr ON pub_dbxref;
   CREATE TRIGGER pub_dbxref_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON pub_dbxref
       FOR EACH ROW
       EXECUTE PROCEDURE pub_dbxref_audit_update_delete_proc();

----------------------------------------------------------------------
--
-- Definitions for pubauthor update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubauthor_audit_ud_tbl;
   CREATE TABLE pubauthor_audit_ud_tbl ( 
       pubauthor_id integer, 
       pub_id integer, 
       rank integer, 
       editor boolean, 
       surname varchar(100), 
       givennames varchar(100), 
       suffix varchar(100), 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on pubauthor_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pubauthor_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       pubauthor_id_var integer; 
       pub_id_var integer; 
       rank_var integer; 
       editor_var boolean; 
       surname_var varchar(100); 
       givennames_var varchar(100); 
       suffix_var varchar(100); 
       
       transaction_type_var char;
   BEGIN
       pubauthor_id_var = OLD.pubauthor_id;
       pub_id_var = OLD.pub_id;
       rank_var = OLD.rank;
       editor_var = OLD.editor;
       surname_var = OLD.surname;
       givennames_var = OLD.givennames;
       suffix_var = OLD.suffix;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO pubauthor_audit_ud_tbl ( 
             pubauthor_id, 
             pub_id, 
             rank, 
             editor, 
             surname, 
             givennames, 
             suffix, 
             transaction_type
       ) VALUES ( 
             pubauthor_id_var, 
             pub_id_var, 
             rank_var, 
             editor_var, 
             surname_var, 
             givennames_var, 
             suffix_var, 
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

   DROP TRIGGER IF EXISTS pubauthor_audit_ud_trgr ON pubauthor;
   CREATE TRIGGER pubauthor_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON pubauthor
       FOR EACH ROW
       EXECUTE PROCEDURE pubauthor_audit_update_delete_proc ();

----------------------------------------------------------------------
--
-- Definitions for pubprop update/delete audit table
--
----------------------------------------------------------------------

   DROP TABLE IF EXISTS pubprop_audit_ud_tbl;
   CREATE TABLE pubprop_audit_ud_tbl ( 
       pubprop_id integer, 
       pub_id integer, 
       type_id integer, 
       value text, 
       rank integer, 
       user_account varchar(30) not null default current_user,
       transaction_date timestamp not null default now(),
       transaction_type char(1) not null
   );
   GRANT ALL on pubprop_audit_ud_tbl to PUBLIC;

   CREATE OR REPLACE FUNCTION pubprop_audit_update_delete_proc() RETURNS trigger AS
   '
   DECLARE
       pubprop_id_var integer; 
       pub_id_var integer; 
       type_id_var integer; 
       value_var text; 
       rank_var integer; 
       
       transaction_type_var char;
   BEGIN
       pubprop_id_var = OLD.pubprop_id;
       pub_id_var = OLD.pub_id;
       type_id_var = OLD.type_id;
       value_var = OLD.value;
       rank_var = OLD.rank;
       
       IF TG_OP = ''DELETE'' THEN
           transaction_type_var = ''D'';
       ELSE
           transaction_type_var = ''U'';
       END IF;

       INSERT INTO pubprop_audit_ud_tbl ( 
             pubprop_id, 
             pub_id, 
             type_id, 
             value, 
             rank, 
             transaction_type
       ) VALUES ( 
             pubprop_id_var, 
             pub_id_var, 
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

   DROP TRIGGER IF EXISTS pubprop_audit_ud_trgr ON pubprop;
   CREATE TRIGGER pubprop_audit_ud_trgr
       BEFORE UPDATE OR DELETE ON pubprop
       FOR EACH ROW
       EXECUTE PROCEDURE pubprop_audit_update_delete_proc();
