--# $Id: companalysis.sql,v 1.6 2002-11-08 00:06:03 cwiel Exp $

-- an analysis is a particular execution of a computational analysis;
-- it may be a blast of one sequence against another, or an all by all
-- blast, or a different kind of analysis altogether.
-- it is a single unit of computation - if different blast runs
-- were instantiated over differnet query sequences, there would
-- be multiple entries here.
--
-- the sequence that was used as the query sequence can be
-- optionally included via queryfeature_id - even though this
-- is redundant with the hitpair table below. this can still
-- be useful - for instance, we may have an analysis that blasts
-- contigs against a database. we may then transform those hits
-- into global coordinates; it can still be useful to keep a record
-- of which contig was blasted as the query.
--
-- name: a way of grouping analyses. this should be a handy
-- short identifier that can help people find an analysis they
-- want. for instance "tRNAscan", "cDNA", "FlyPep", "SwissProt"
--
-- program: e.g. blastx, blastp, sim4, genscan
-- programversion: e.g. TBLASTX 2.0MP-WashU [09-Nov-2000]
-- algorithm: eg blast
-- sourcename: eg cDNA, SwissProt
--
-- MAPPING (bioperl): maps to Bio::Search::Result::ResultI

create table analysis (
    analysis_id serial not null,
    primary key (analysis_id),
    name varchar(255),
    adesc text,
    program varchar(255) not null,
    programversion varchar(255) not null,
    algorithm varchar(255),
    sourcename varchar(255) not null,
    sourceversion varchar(255) not null,
    queryfeature_id int,
    foreign key (queryfeature_id) references feature (feature_id),
    unique (program, programversion, sourcename, sourceversion),

    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);

-- analyses can have various properties attached - eg the parameters
-- used in running a blast
create table analysisprop (
    analysis_id int not null,
    foreign key (analysis_id) references analysis (analysis_id),
    pkey_id int not null,
    foreign key (pkey_id) references cvterm (cvterm_id),
    pval text,
    unique (analysis_id, pkey_id, pval),

    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);

-- MAPPING (bioperl): Bio::Search::Hit::HitI
create table hitpair (
    hitpair_id serial not null,
    primary key (hitpair_id),
    analysis_id int not null,
    foreign key (analysis_id) references analysis (analysis_id),
    qfeature_id int not null,
    foreign key (qfeature_id) references feature (feature_id),
    sfeature_id int not null,
    foreign key (sfeature_id) references feature (feature_id),
    hitrawscore double precision,
    hitnormscore double precision,
    hitsignificance double precision,
    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);

-- MAPPING (bioperl): Bio::Search::HSP::HSPI
create table hsp (
    hsp_id serial not null,
    hitpair_id int not null,
    foreign key (hitpair_id) references hitpair (hitpair_id),
    qnbeg int not null,
    qnend int not null,
    qstrand smallint not null,
    snbeg int not null,
    snend int not null,
    sstrand smallint not null,
    hsprawscore double precision,
    hspnormscore double precision,
    hspsignificance double precision,
    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);

create table scoredfeature (
    feature_id int not null,
    foreign key (feature_id) references feature (feature_id),
    rawscore double precision,
    normscore double precision,
    significance double precision,
    unique (feature_id)
);

create table hspprop (
    hsp_id int not null,
    foreign key (hsp_id) references hsp (hsp_id),
    hsppkey_id int not null,
    foreign key (hsppkey_id) references cvterm (cvterm_id),
    apval text,
    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);

-- NOT YET STABLE
create table multalign (
    multalign_id serial not null,
    primary key (multalign_id),
    analysis_id int not null,
    foreign key (analysis_id)  references analysis (analysis_id),
    scorestr varchar(255),
    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);


create table multalign_feature (
    multalign_id int not null,
    foreign key (multalign_id) references multalign (multalign_id),
    feature_id int not null,
    foreign key (feature_id) references feature (feature_id),
    timeentered timestamp not null default current_timestamp,
    timelastmod timestamp not null default current_timestamp
);

