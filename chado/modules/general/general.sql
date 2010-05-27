-- $Id: general.sql,v 1.31 2007-03-01 02:45:54 briano Exp $
-- ==========================================
-- Chado general module
--
-- ================================================
-- TABLE: tableinfo
-- ================================================

create table tableinfo (
    tableinfo_id serial not null,
    primary key (tableinfo_id),
    name varchar(30) not null,
    primary_key_column varchar(30) null,
    is_view int not null default 0,
    view_on_table_id int null,
    superclass_table_id int null,
    is_updateable int not null default 1,
    modification_date date not null default now(),
    constraint tableinfo_c1 unique (name)
);

COMMENT ON TABLE tableinfo IS NULL;

-- ================================================
-- TABLE: db
-- ================================================

create table db (
    db_id serial not null,
    primary key (db_id),
    name varchar(255) not null,
--    contact_id int,
--    foreign key (contact_id) references contact (contact_id) on delete cascade INITIALLY DEFERRED,
    description varchar(255) null,
    urlprefix varchar(255) null,
    url varchar(255) null,
    constraint db_c1 unique (name)
);

COMMENT ON TABLE db IS 'A database authority. Typical databases in
bioinformatics are FlyBase, GO, UniProt, NCBI, MGI, etc. The authority
is generally known by this shortened form, which is unique within the
bioinformatics and biomedical realm.  To Do - add support for URIs,
URNs (e.g. LSIDs). We can do this by treating the URL as a URI -
however, some applications may expect this to be resolvable - to be
decided.';

-- ================================================
-- TABLE: dbxref
-- ================================================

create table dbxref (
    dbxref_id serial not null,
    primary key (dbxref_id),
    db_id int not null,
    foreign key (db_id) references db (db_id) on delete cascade INITIALLY DEFERRED,
    accession varchar(255) not null,
    version varchar(255) not null default '',
    description text,
    constraint dbxref_c1 unique (db_id,accession,version)
);
create index dbxref_idx1 on dbxref (db_id);
create index dbxref_idx2 on dbxref (accession);
create index dbxref_idx3 on dbxref (version);

COMMENT ON TABLE dbxref IS 'A unique, global, public, stable identifier. Not necessarily an external reference - can reference data items inside the particular chado instance being used. Typically a row in a table can be uniquely identified with a primary identifier (called dbxref_id); a table may also have secondary identifiers (in a linking table <T>_dbxref). A dbxref is generally written as <DB>:<ACCESSION> or as <DB>:<ACCESSION>:<VERSION>.';

COMMENT ON COLUMN dbxref.accession IS 'The local part of the identifier. Guaranteed by the db authority to be unique for that db.';

-- ================================================
-- TABLE: project
-- ================================================

create table project (
    project_id serial not null,  
    primary key (project_id),
    name varchar(255) not null,
    description varchar(255) not null,
    constraint project_c1 unique (name)
);

COMMENT ON TABLE project IS NULL;

-- ================================================
-- TABLE: projectprop
-- ================================================

CREATE TABLE projectprop (
	projectprop_id serial NOT NULL,
	PRIMARY KEY (projectprop_id),
	project_id integer NOT NULL,
	FOREIGN KEY (project_id) REFERENCES project (project_id) ON DELETE CASCADE,
	cvterm_id integer NOT NULL,
	FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE,
	value text,
	rank integer not null default 0,
	CONSTRAINT projectprop_c1 UNIQUE (project_id, cvterm_id, rank)
);

-- ================================================
-- TABLE: project_relationship
-- ================================================

CREATE TABLE project_relationship (
	project_relationship_id serial NOT NULL,
	PRIMARY KEY (project_relationship_id),
	subject_project_id integer NOT NULL,
	FOREIGN KEY (subject_project_id) REFERENCES project (project_id) ON DELETE CASCADE,
	object_project_id integer NOT NULL,
	FOREIGN KEY (object_project_id) REFERENCES project (project_id) ON DELETE CASCADE,
	type_id integer NOT NULL,
	FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE RESTRICT,
	CONSTRAINT project_relationship_c1 UNIQUE (subject_project_id, object_project_id, type_id)
);
COMMENT ON TABLE project_relationship IS 'A project can be composed of several smaller scale projects';
COMMENT ON COLUMN project_relationship.type_id IS 'The type of relationship being stated, such as "is part of".';


create table project_pub (
       project_pub_id serial not null,
       primary key (project_pub_id),
       project_id int not null,
       foreign key (project_id) references project (project_id) on delete cascade INITIALLY DEFERRED,
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id) on delete cascade INITIALLY DEFERRED,
       constraint project_pub_c1 unique (project_id,pub_id)
);
create index project_pub_idx1 on project_pub (project_id);
create index project_pub_idx2 on project_pub (pub_id);

COMMENT ON TABLE project_pub IS 'Linking project(s) to publication(s)';