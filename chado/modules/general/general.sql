-- ================================================
-- TABLE: tableinfo
-- ================================================

create table tableinfo (
       tableinfo_id serial not null,
       primary key (tableinfo_id),
       name varchar(30) not null,
--       table_type varchar(40) not null,
       primary_key_column varchar(30) null,
--       is_versioned int not null,
       is_view int not null default 0,
       view_on_table_id int null,
       superclass_table_id int null,
       is_updateable int not null default 1,
       modification_date date not null default now()
);
insert into tableinfo (name,primary_key_column) values('tableinfo','tableinfo_id');

--
-- should this be in pub?
--
-- ================================================
-- TABLE: contact
-- ================================================
create table contact (
       contact_id serial not null,
       primary key (contact_id),
-- fields to be added after discussion
       description varchar(255) null
);
insert into tableinfo (name,primary_key_column) values('contact','contact_id');

-- ================================================
-- TABLE: db
-- ================================================

create table db (
       db_id serial not null,
       primary key (db_id),
       name varchar(255) not null,
       contact_id int not null,
       foreign key (contact_id) references contact (contact_id),
       description varchar(255) null,
       urlprefix varchar(255) null,
       url varchar(255) null,
       unique (name)
);
insert into tableinfo (name,primary_key_column) values('db','db_id');


-- ================================================
-- TABLE: dbxref
-- ================================================

create table dbxref (
       dbxref_id serial not null,
       primary key (dbxref_id),
       db_id int not null,
       foreign key (db_id) references db (db_id),
       accession varchar(255) not null,
       version varchar(255) not null default '',
       description text,

       unique (db_id, accession, version)
);
insert into tableinfo (name,primary_key_column) values('dbxref','dbxref_id');

--
-- this table pending review
--
-- ================================================
-- TABLE: dbxrefprop
-- ================================================

create table dbxrefprop (
       dbxrefprop_id serial not null,
       primary key (dbxrefprop_id),
       dbxref_id int not null,
       foreign key (dbxref_id) references dbxref (dbxref_id),
       pkey_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       value text not null default '',
       rank int not null default 0,

       unique(dbxref_id, type_id, pval, rank)
);
create index dbxrefprop_idx1 on dbxrefprop (dbxref_id);
create index dbxrefprop_idx2 on dbxrefprop (type_id);

--
-- this table pending review
--
-- ================================================
-- TABLE: dbxrefrelationship
-- ================================================
--
--create table dbxrefrelationship (
--       dbxrefrelationship_id serial not null,
--       primary key (dbxrefrelationship_id),
--       reltype_id int not null,
--       foreign key (reltype_id) references cvterm (cvterm_id),
--       subjterm_id int not null,
--       foreign key (subjterm_id) references dbxref (dbxref_id),
--       objterm_id int not null,
--       foreign key (objterm_id) references dbxref (dbxref_id),
--       
--       unique(reltype_id, subjterm_id, objterm_id)
--);
--create index dbxrefrelationship_idx1 on dbxrefrelationship (reltype_id);
--create index dbxrefrelationship_idx2 on dbxrefrelationship (subjterm_id);
--create index dbxrefrelationship_idx3 on dbxrefrelationship (objterm_id);

-- ================================================
-- TABLE: project
-- ================================================
create table project (
       project_id serial not null,
       primary key (project_id),
       name varchar(255) not null,
       description varchar(255) not null
);

insert into tableinfo (name,primary_key_column) values('project','project_id');
