-- For an overview of this module, see cv-intro.txt
--
-- THIS COPY IS CURRENTLY ON BRANCH bdgp-dev
--
-- Changes in branch:
-- new table: cvtermprop
-- new column cvterm.is_obsolete
-- new column cvterm.is_relationshiptype
-- new column cvterm_dbxref.is_for_definition
-- new column cvtermsynonym.type_id
-- insert statement to ensure is_a relationship is always present

-- ================================================
-- TABLE: cv
-- ================================================

create table cv (
       cv_id serial not null,
       primary key (cv_id),
       name varchar(255) not null,
       definition text,

       unique(name)
);

-- ================================================
-- TABLE: cvterm
-- ================================================

create table cvterm (
       cvterm_id serial not null,
       primary key (cvterm_id),
       cv_id int not null,
       foreign key (cv_id) references cv (cv_id) on delete cascade,
       name varchar(512) not null,
       definition text,
       dbxref_id int not null,
       foreign key (dbxref_id) references dbxref (dbxref_id) on delete set null,
       is_obsolete int not null default 0,
       is_relationshiptype int not null default 0,
       
       constraint cvterm_c1 unique (dbxref_id),
       constraint cvterm_c2 unique (name, cv_id, is_obsolete)
);
create index cvterm_idx1 on cvterm (cv_id);

COMMENT ON TABLE cvterm IS
 'A term, class or concept within an ontology or controlled vocabulary.
  Also used for relationship types. A cvterm can also be thought of
  as a node in a graph';
COMMENT ON COLUMN cvterm.cv_id IS
 'The cv/ontology/namespace to which this cvterm belongs';
COMMENT ON COLUMN cvterm.name IS
 'A concise human-readable name describing the meaning of the cvterm';
COMMENT ON COLUMN cvterm.definition IS
 'A human-readable text definition';
COMMENT ON COLUMN cvterm.dbxref_id IS
 'Primary dbxref - The unique global OBO identifier for this cvterm.
  Note that a cvterm may  have multiple secondary dbxrefs - see also
  table: cvterm_dbxref';
COMMENT ON COLUMN cvterm.is_obsolete IS
 'Boolean 0=false,1=true; see GO documentation for details of obsoletion.
  note that two terms with different primary dbxrefs may exist if one
  is obsolete';
COMMENT ON COLUMN cvterm.is_relationshiptype IS
 'Boolean 0=false,1=true
  Relationship types (also known as Typedefs in OBO format, or as
  properties or slots) form a cv/ontology in themselves. We use this
  flag to indicate whether this cvterm is an actual term/concept or
  a relationship type';
COMMENT ON INDEX cvterm_c1 IS 
 'the OBO identifier is globally unique';
COMMENT ON INDEX cvterm_c2 IS 
 'a name can mean different things in different contexts;
  for example "chromosome" in SO and GO. A name should be unique
  within an ontology/cv. A name may exist twice in a cv, in both
  obsolete and non-obsolete forms - these will be for different
  cvterms with different OBO identifiers; so GO documentation for
  more details on obsoletion';



-- ================================================
-- TABLE: cvterm_relationship
-- ================================================

create table cvterm_relationship (
       cvterm_relationship_id serial not null,
       primary key (cvterm_relationship_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id) on delete cascade,
       subject_id int not null,
       foreign key (subject_id) references cvterm (cvterm_id) on delete cascade,
       object_id int not null,
       foreign key (object_id) references cvterm (cvterm_id) on delete cascade,

       unique(type_id, subject_id, object_id)
);
create index cvterm_relationship_idx1 on cvterm_relationship (type_id);
create index cvterm_relationship_idx2 on cvterm_relationship (subject_id);
create index cvterm_relationship_idx3 on cvterm_relationship (object_id);

COMMENT ON TABLE cvterm_relationship IS
 'A relationship linking two cvterms. A relationship can be thought of
  as an edge in a graph, or as a natural language statement about
  two cvterms. The statement is of the form SUBJECT PREDICATE OBJECT;
  for example "wing part_of body"';

-- ================================================
-- TABLE: cvtermpath
-- ================================================

create table cvtermpath (
       cvtermpath_id serial not null,
       primary key (cvtermpath_id),
       type_id int,
       foreign key (type_id) references cvterm (cvterm_id) on delete set null,
       subject_id int not null,
       foreign key (subject_id) references cvterm (cvterm_id) on delete cascade,
       object_id int not null,
       foreign key (object_id) references cvterm (cvterm_id) on delete cascade,
       cv_id int not null,
       foreign key (cv_id) references cv (cv_id) on delete cascade,
       pathdistance int
);
create index cvtermpath_idx1 on cvtermpath (type_id);
create index cvtermpath_idx2 on cvtermpath (subject_id);
create index cvtermpath_idx3 on cvtermpath (object_id);
create index cvtermpath_idx4 on cvtermpath (cv_id);
create unique index cvtermpath_idx5 on cvtermpath (subject_id, object_id, type_id, pathdistance);


-- ================================================
-- TABLE: cvtermsynonym
-- ================================================

-- synonyms can have optional types: e.g. narrower_than, exact

create table cvtermsynonym (
       cvtermsynonym_id serial not null,
       primary key (cvtermsynonym_id),
       cvterm_id int not null,
       foreign key (cvterm_id) references cvterm (cvterm_id) on delete cascade,
       synonym varchar(255) not null,
       type_id int,
       foreign key (type_id) references cvterm (cvterm_id) on delete cascade,

       unique(cvterm_id, synonym)
);
create index cvtermsynonym_idx1 on cvtermsynonym (cvterm_id);


-- ================================================
-- TABLE: cvterm_dbxref
-- ================================================

create table cvterm_dbxref (
       cvterm_dbxref_id serial not null,
       primary key (cvterm_dbxref_id),
       cvterm_id int not null,
       foreign key (cvterm_id) references cvterm (cvterm_id) on delete cascade,
       dbxref_id int not null,
       foreign key (dbxref_id) references dbxref (dbxref_id) on delete cascade,
       is_for_definition int not null default 0,

       unique(cvterm_id, dbxref_id)
);
create index cvterm_dbxref_idx1 on cvterm_dbxref (cvterm_id);
create index cvterm_dbxref_idx2 on cvterm_dbxref (dbxref_id);

-- ================================================
-- TABLE: cvtermprop
-- ================================================

create table cvtermprop (
       cvtermprop_id serial not null,
       primary key (cvtermprop_id),
       cvterm_id int not null,
       foreign key (cvterm_id) references cvterm (cvterm_id) on delete cascade,
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id) on delete cascade,
       value text not null default '',
       rank int not null default 0,

       unique(cvterm_id, type_id, value, rank)
);

-- ================================================
-- TABLE: dbxrefprop
-- ================================================

create table dbxrefprop (
       dbxrefprop_id serial not null,
       primary key (dbxrefprop_id),
       dbxref_id int not null,
       foreign key (dbxref_id) references dbxref (dbxref_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       value text not null default '',
       rank int not null default 0,

       unique(dbxref_id, type_id, value, rank)
);
create index dbxrefprop_idx1 on dbxrefprop (dbxref_id);
create index dbxrefprop_idx2 on dbxrefprop (type_id);

