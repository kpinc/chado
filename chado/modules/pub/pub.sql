-- We should take a look in OMG for a standard representation we might use 
-- instead of this.

-- ================================================
-- TABLE: pub
-- ================================================

create table pub (
       pub_id serial not null,
       primary key (pub_id),
       title text,
       volumetitle text,
       volume  varchar(255),
       series_name varchar(255),
       issue  varchar(255),
       pyear  varchar(255),
       pages  varchar(255),
       miniref varchar(255) not null,
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       is_obsolete boolean default 'false',
       publisher varchar(255),
       pubplace varchar(255),

       unique(miniref)
);
-- title: title of paper, chapter of book, journal, etc
-- volumetitle: title of part if one of a series
-- series_name: full name of (journal) series
-- pages: page number range[s], eg, 457--459, viii + 664pp, lv--lvii
-- type_id: the type of the publication (book, journal, poem, graffiti, etc)
-- is_obsolete: do we want this even though we have the relationship in pub_relationship?
insert into tableinfo (name,primary_key_column) values('pub','pub_id');
create index pub_idx1 on pub (type_id);

-- ================================================
-- TABLE: pubrelationship
-- ================================================

-- Handle relationships between publications, eg, when one publication
-- makes others obsolete, when one publication contains errata with
-- respect to other publication(s), or when one publication also 
-- appears in another pub (I think these three are it - at least for fb)

create table pubrelationship (
       pubrelationship_id serial not null,
       primary key (pubrelationship_id),
       subject_id int not null,
       foreign key (subject_id) references pub (pub_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       object_id int not null,
       foreign key (object_id) references pub (pub_id),

       unique(subject_id, object_id, type_id)
);
insert into tableinfo (name,primary_key_column) values('pubrelationship','pubrelationship_id');
create index pubrelationship_idx1 on pubrelationship (subject_id);
create index pubrelationship_idx2 on pubrelationship (object_id);
create index pubrelationship_idx3 on pubrelationship (type_id);


-- ================================================
-- TABLE: pub_dbxref
-- ================================================

-- Handle links to eg, pubmed, biosis, zoorec, OCLC, mdeline, ISSN, coden...

create table pub_dbxref (
       pub_dbxref_id serial not null,
       primary key (pub_dbxref_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),
       dbxref_id int not null,
       foreign key (dbxref_id) references dbxref (dbxref_id),

       unique(pub_id,dbxref_id)
);
insert into tableinfo (name,primary_key_column) values('pub_dbxref','pub_dbxref_id');
create index pub_dbxref_idx1 on pub_dbxref (pub_id);
create index pub_dbxref_idx2 on pub_dbxref (dbxref_id);


-- ================================================
-- TABLE: author
-- ================================================

-- using the FB author table columns

create table author (
       author_id serial not null,
       primary key (author_id),
       contact_id int not null,
       foreign key (contact_id) references contact (contact_id),
-- these fields may be moving to the contact table...
       surname varchar(100) not null,
       givennames varchar(100),
       suffix varchar(100),

       unique(surname,givennames,suffix)
);
-- givennames: first name, initials
-- suffix: Jr., Sr., etc       
insert into tableinfo (name,primary_key_column) values('author','author_id');


-- ================================================
-- TABLE: pub_author
-- ================================================

create table pub_author (
       pub_author_id serial not null,
       primary key (pub_author_id),
       author_id int not null,
       foreign key (author_id) references author (author_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),

       unique(author_id,pub_id)
);
-- rank: order of author in author list for this pub
-- editor: indicates whether the author is an editor for linked publication
insert into tableinfo (name,primary_key_column) values('pub_author','pub_author_id');
create index pub_author_idx1 on pub_author (author_id);
create index pub_author_idx2 on pub_author (pub_id);

-- ================================================
-- TABLE: pub_authorprop
-- ================================================

create table pub_authorprop (
       pub_authorprop_id serial not null,
       primary key (pub_authorprop_id),
       pub_author_id int not null,
       foreign key (pub_author_id) references pub_author (pub_author_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       value text not null,
       rank integer,

       unique(pub_author_id,type_id,value)
);
insert into tableinfo (name,primary_key_column) values('pub_authorprop','pub_authorprop_id');
create index pub_authorprop_idx1 on pub_authorprop (pub_author_id);
create index pub_authorprop_idx2 on pub_authorprop (type_id);


-- ================================================
-- TABLE: pubprop
-- ================================================

create table pubprop (
       pubprop_id serial not null,
       primary key (pubprop_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       value text not null,
       rank integer,

       unique(pub_id,type_id,value)
);
insert into tableinfo (name,primary_key_column) values('pubprop','pubprop_id');
create index pubprop_idx1 on pubprop (pub_id);
create index pubprop_idx2 on pubprop (type_id);

