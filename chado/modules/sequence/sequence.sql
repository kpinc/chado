-- ================================================
-- TABLE: feature
-- ================================================

create table feature (
       feature_id serial not null,
       primary key (feature_id),
       dbxref_id int,
       foreign key (dbxref_id) references dbxref (dbxref_id),
       organism_id int not null,
       foreign key (organism_id) references organism (organism_id),
       name varchar(255),
       uniquename text not null,
       residues text,
       seqlen int,
       md5checksum char(32),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
	is_analysis boolean not null default 'false',
-- timeaccessioned and timelastmodified are for handling object accession/
-- modification timestamps (as opposed to db auditing info, handled elsewhere).
-- The expectation is that these fields would be available to software 
-- interacting with chado.
       timeaccessioned timestamp not null default current_timestamp,
       timelastmodified timestamp not null default current_timestamp,

       unique(organism_id,uniquename)
);
-- dbxref_id here is intended for the primary dbxref for this feature.   
-- Additional dbxref links are made via feature_dbxref
-- name: the human-readable common name for a feature, for display
-- uniquename: the unique name for a feature; may not be particularly human-readable

-- timeaccessioned and timelastmodified are for handling object accession/
-- modification timestamps (as opposed to db auditing info, handled elsewhere).
-- The expectation is that these fields would be available to software 
-- interacting with chado.
insert into tableinfo (name,primary_key_column) values('feature','feature_id');
create sequence feature_uniquename_seq;
create index feature_name_ind1 on feature(name);
create index feature_idx1 on feature (dbxref_id);
create index feature_idx2 on feature (organism_id);
create index feature_idx3 on feature (type_id);
create index feature_idx4 on feature (uniquename);
create index feature_lc_name on feature (lower(name));



-- ================================================
-- TABLE: featureloc
-- ================================================

-- each feature can have 0 or more locations.
-- multiple locations do NOT indicate non-contiguous locations.
-- instead they designate alternate locations or grouped locations;
-- for instance, a feature designating a blast hit or hsp will have two
-- locations, one on the query feature, one on the subject feature.
-- features representing sequence variation could have alternate locations
-- instantiated on a feature on the mutant strain.
-- the field "rank" is used to differentiate these different locations.
-- the default rank '0' is used for the main/primary location (eg in
-- similarity features, 0 is query, 1 is subject), although sometimes
-- this will be symmeytical and there is no primary location.
--
-- redundant locations can also be stored - for instance, the position
-- of an exon on a BAC and in global coordinates. the field "locgroup"
-- is used to differentiate these groupings of locations. the default
-- locgroup '0' is used for the main/primary location, from which the
-- others can be derived via coordinate transformations. another
-- example of redundant locations is storing ORF coordinates relative
-- to both transcript and genome. redundant locations open the possibility
-- of the database getting into inconsistent states; this schema gives
-- us the flexibility of both 'warehouse' instantiations with redundant
-- locations (easier for querying) and 'management' instantiations with
-- no redundant locations.

-- most features (exons, transcripts, etc) will have 1 location, with
-- locgroup and rank equal to 0
--
-- an example of using both locgroup and rank:
-- imagine a feature indicating a conserved region between the chromosomes
-- of two different species. we may want to keep redundant locations on
-- both contigs and chromosomes. we would thus have 4 locations for the
-- single conserved region feature - two distinct locgroups (contig level
-- and chromosome level) and two distinct ranks (for the two species).

-- altresidues is used to store alternate residues of a feature, when these
-- differ from feature.residues. for instance, a SNP feature located on
-- a wild and mutant protein would have different alresidues.
-- for alignment/similarity features, the altresidues is used to represent
-- the alignment string.

-- note on variation features; even if we don't want to instantiate a mutant
-- chromosome/contig feature, we can still represent a SNP etc with 2 locations,
-- one (rank 0) on the genome, the other (rank 1) would have most fields null,
-- except for altresidues

-- IMPORTANT: fnbeg and fnend are space-based (INTERBASE) coordinates
-- this is vital as it allows us to represent zero-length
-- features eg splice sites, insertion points without
-- an awkward fuzzy system

-- Note that nbeg and nend have been replaced with fmin and fmax,
-- which are the minimum and maximum coordinates of the feature
-- relative to the parent feature.  By contrast,
-- nbeg, nend are for feature natural begin/end
-- by natural begin, end we mean these are the actual
-- beginning (5' position) and actual end (3' position)
-- rather than the low position and high position, as
-- these terms are sometimes erroneously used.  To compensate
-- for the removal of nbeg and nend from featureloc, a view
-- based on featureloc, dfeatureloc, is provided in sequence_views.sql.

create table featureloc (
       featureloc_id serial not null,
       primary key (featureloc_id),

       feature_id int not null,
       foreign key (feature_id) references feature (feature_id),
       srcfeature_id int,
       foreign key (srcfeature_id) references feature (feature_id),

       fmin int,
       is_fmin_partial boolean not null default 'false',
       fmax int,
       is_fmax_partial boolean not null default 'false',
       strand smallint,
       phase int,

       residue_info text,

       locgroup int not null default 0,
       rank     int not null default 0,

       unique (feature_id, locgroup, rank)
);
-- phase: phase of translation wrt srcfeature_id.  Values are 0,1,2
insert into tableinfo (name,primary_key_column) values('featureloc','featureloc_id');
create index featureloc_idx1 on featureloc (feature_id);
create index featureloc_idx2 on featureloc (srcfeature_id);
create index featureloc_idx3 on featureloc (srcfeature_id,fmin,fmax);

-- ================================================
-- TABLE: feature_pub
-- ================================================

create table feature_pub (
       feature_pub_id serial not null,
       primary key (feature_pub_id),
       feature_id int not null,
       foreign key (feature_id) references feature (feature_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),

       unique(feature_id, pub_id)
);
insert into tableinfo (name,primary_key_column) values('feature_pub','feature_pub_id');
create index feature_pub_idx1 on feature_pub (feature_id);
create index feature_pub_idx2 on feature_pub (pub_id);


-- ================================================
-- TABLE: featureprop
-- ================================================

create table featureprop (
       featureprop_id serial not null,
       primary key (featureprop_id),
       feature_id int not null,
       foreign key (feature_id) references feature (feature_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       value text not null default '',
       rank int not null default 0,

       unique(feature_id, type_id, value, rank)
);
insert into tableinfo (name,primary_key_column) values('featureprop','featureprop_id');
create index featureprop_idx1 on featureprop (feature_id);
create index featureprop_idx2 on featureprop (type_id);


-- ================================================
-- TABLE: featureprop_pub
-- ================================================

create table featureprop_pub (
       featureprop_pub_id serial not null,
       primary key (featureprop_pub_id),
       featureprop_id int not null,
       foreign key (featureprop_id) references featureprop (featureprop_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),

       unique(featureprop_id, pub_id)
);
insert into tableinfo (name,primary_key_column) values('featureprop_pub','featureprop_pub_id');
create index featureprop_pub_idx1 on featureprop_pub (featureprop_id);
create index featureprop_pub_idx2 on featureprop_pub (pub_id);


-- ================================================
-- TABLE: feature_dbxref
-- ================================================
-- links a feature to dbxrefs.  Note that there is also feature.dbxref_id
-- link for the primary dbxref link.
create table feature_dbxref (
       feature_dbxref_id serial not null,
       primary key (feature_dbxref_id),
       feature_id int not null,
       foreign key (feature_id) references feature (feature_id),
       dbxref_id int not null,
       foreign key (dbxref_id) references dbxref (dbxref_id),
       is_current boolean not null default 'true',

       unique(feature_id, dbxref_id)
);
insert into tableinfo (name,primary_key_column) values('feature_dbxref','feature_dbxref_id');
create index feature_dbxref_idx1 on feature_dbxref (feature_id);
create index feature_dbxref_idx2 on feature_dbxref (dbxref_id);


-- ================================================
-- TABLE: featurerelationship
-- ================================================

-- features can be arranged in graphs, eg exon partof transcript 
-- partof gene; translation madeby transcript
-- if type is thought of as a verb, each arc makes a statement
-- [SUBJECT VERB OBJECT]
-- object can also be thought of as parent, and subject as child
--
-- we include the relationship rank/order, because even though
-- most of the time we can order things implicitly by sequence
-- coordinates, we can't always do this - eg transpliced genes.
-- it's also useful for quickly getting implicit introns

create table featurerelationship (
       featurerelationship_id serial not null,
       primary key (featurerelationship_id),
       subject_id int not null,
       foreign key (subject_id) references feature (feature_id),
       object_id int not null,
       foreign key (object_id) references feature (feature_id),
       type_id int not null,
       foreign key (type_id) references cvterm (cvterm_id),
       rank int,

       unique(subject_id, object_id, type_id)
);
insert into tableinfo (name,primary_key_column) values('featurerelationship','featurerelationship_id');
create index featurerelationship_idx1 on featurerelationship (subject_id);
create index featurerelationship_idx2 on featurerelationship (object_id);
create index featurerelationship_idx3 on featurerelationship (type_id);


-- ================================================
-- TABLE: feature_cvterm
-- ================================================

create table feature_cvterm (
       feature_cvterm_id serial not null,
       primary key (feature_cvterm_id),
       feature_id int not null,
       foreign key (feature_id) references feature (feature_id),
       cvterm_id int not null,
       foreign key (cvterm_id) references cvterm (cvterm_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),

       unique (feature_id, cvterm_id, pub_id)

);
insert into tableinfo (name,primary_key_column) values('feature_cvterm','feature_cvterm_id');
create index feature_cvterm_idx1 on feature_cvterm (feature_id);
create index feature_cvterm_idx2 on feature_cvterm (cvterm_id);
create index feature_cvterm_idx3 on feature_cvterm (pub_id);


-- ================================================
-- TABLE: synonym
-- ================================================

create table synonym (
       synonym_id serial not null,
       primary key (synonym_id),
       name varchar(255) not null,
       type_id int not null,
       synonym_sgml varchar(255) not null,
       foreign key (type_id) references cvterm (cvterm_id),

       unique(name,type_id)
);
-- type_id: types would be symbol and fullname for now
-- synonym_sgml: sgml-ized version of symbols
create index synonym_idx1 on synonym (type_id);


-- ================================================
-- TABLE: feature_synonym
-- ================================================

create table feature_synonym (
       feature_synonym_id serial not null,
       primary key (feature_synonym_id),
       synonym_id int not null,
       foreign key (synonym_id) references synonym (synonym_id),
       feature_id int not null,
       foreign key (feature_id) references feature (feature_id),
       pub_id int not null,
       foreign key (pub_id) references pub (pub_id),
       is_current boolean not null,
       is_internal boolean not null default 'false',

       unique(synonym_id, feature_id, pub_id)
);
-- pub_id: the pub_id link is for relating the usage of a given synonym to the
-- publication in which it was used
-- is_current: the is_current bit indicates whether the linked synonym is the 
-- current -official- symbol for the linked feature
-- is_internal: typically a synonym exists so that somebody querying the db with an
-- obsolete name can find the object they're looking for (under its current
-- name.  If the synonym has been used publicly & deliberately (eg in a 
-- paper), it my also be listed in reports as a synonym.   If the synonym 
-- was not used deliberately (eg, there was a typo which went public), then 
-- the is_internal bit may be set to 'true' so that it is known that the 
-- synonym is "internal" and should be queryable but should not be listed 
-- in reports as a valid synonym.
insert into tableinfo (name,primary_key_column) values('feature_synonym','feature_synonym_id');
create index feature_synonym_idx1 on feature_synonym (synonym_id);
create index feature_synonym_idx2 on feature_synonym (feature_id);
create index feature_synonym_idx3 on feature_synonym (pub_id);
