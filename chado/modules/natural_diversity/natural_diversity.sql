-- =================================================================
-- Dependencies:
--
-- :import feature from sequence
-- :import cvterm from cv
-- :import pub from pub
-- :import phenotype from phenotype
-- :import organism from organism
-- :import genotype from genetic
-- :import contfc_act from contact
-- :import project from general
-- :import stock from stock
-- :import synonym
-- =================================================================


-- this probably needs some work, depending on how cross-database we
-- want to be.  In Postgres, at least, there are much better ways to 
-- represent geo information.

CREATE TABLE nd_geolocation (
    geolocation_id serial PRIMARY KEY NOT NULL,
    description character varying(255),
    latitude real,
    longitude real,
    geodetic_datum character varying(32),
    altitude real
);

COMMENT ON TABLE nd_geolocation IS 'The geo-referencable location of the stock. NOTE: This entity is subject to change as a more general and possibly more OpenGIS-compliant geolocation module may be introduced into Chado.';

COMMENT ON COLUMN nd_geolocation.description IS 'A textual representation of the location, if this is the original georeference. Optional if the original georeference is available in lat/long coordinates.';


COMMENT ON COLUMN nd_geolocation.latitude IS 'The decimal latitude coordinate of the georeference, using positive and negative sign to indicate N and S, respectively.';

COMMENT ON COLUMN nd_geolocation.longitude IS 'The decimal longitude coordinate of the georeference, using positive and negative sign to indicate E and W, respectively.';

COMMENT ON COLUMN nd_geolocation.geodetic_datum IS 'The geodetic system on which the geo-reference coordinates are based. For geo-references measured between 1984 and 2010, this will typically be WGS84.';

COMMENT ON COLUMN nd_geolocation.altitude IS 'The altitude (elevation) of the location in meters. If the altitude is only known as a range, this is the average, and altitude_dev will hold half of the width of the range.';



CREATE TABLE nd_assay (
    assay_id serial PRIMARY KEY NOT NULL,
    geolocation_id integer NOT NULL references nd_geolocation (geolocation_id) on delete cascade INITIALLY DEFERRED,
    type_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED 
);

--
--used to be nd_diversityexperiemnt_project
CREATE TABLE nd_assay_project (
    assay_project_id serial PRIMARY KEY NOT NULL,
    project_id integer references project (project_id) on delete cascade INITIALLY DEFERRED,
    assay_id integer NOT NULL references nd_assay (assay_id) on delete cascade INITIALLY DEFERRED
);



CREATE TABLE nd_assayprop (
    assayprop_id serial PRIMARY KEY NOT NULL,
    assay_id integer NOT NULL references nd_assay (assay_id) on delete cascade INITIALLY DEFERRED,
    cvterm_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED ,
    value character varying(255) NOT NULL,
    rank integer NOT NULL,
    constraint assayprop_c1 unique (assay_id,cvterm_id,rank)
);



CREATE TABLE nd_geolocationprop (
    geolocationprop_id serial PRIMARY KEY NOT NULL,
    geolocation_id integer NOT NULL references nd_geolocation (geolocation_id) on delete cascade INITIALLY DEFERRED,
    cvterm_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    value character varying(250) NOT NULL,
    rank integer NOT NULL,
    constraint geolocationprop_c1 unique (geolocation_id,cvterm_id,rank)
);

COMMENT ON TABLE nd_geolocationprop IS 'Property/value associations for geolocations. This table can store the properties such as location and environment';

COMMENT ON COLUMN nd_geolocationprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN nd_geolocationprop.value IS 'The value of the property.';

COMMENT ON COLUMN nd_geolocationprop.rank IS 'The rank of the property value, if the property has an array of values.';


CREATE TABLE nd_protocol (
    protocol_id serial PRIMARY KEY  NOT NULL,
    name character varying(255) NOT NULL unique
);

COMMENT ON TABLE nd_protocol IS 'A protocol can be anything that is done as part of the assay.';

COMMENT ON COLUMN nd_protocol.name IS 'The protocol name.';

CREATE TABLE nd_reagent (
    reagent_id serial PRIMARY KEY NOT NULL,
    name character varying(80) NOT NULL,
    type_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    feature_id integer
);

COMMENT ON TABLE nd_reagent IS 'A reagent such as a primer, an enzyme, an adapter oligo, a linker oligo. Reagents are used in genotyping assays, or in any other kind of assay.';

COMMENT ON COLUMN nd_reagent.name IS 'The name of the reagent. The name should be unique for a given type.';

COMMENT ON COLUMN nd_reagent.type_id IS 'The type of the reagent, for example linker oligomer, or forward primer.';

COMMENT ON COLUMN nd_reagent.feature_id IS 'If the reagent is a primer, the feature that it corresponds to. More generally, the corresponding feature for any reagent that has a sequence that maps to another sequence.';



CREATE TABLE nd_protocol_reagent (
    protocol_reagent_id serial PRIMARY KEY NOT NULL,
    protocol_id integer NOT NULL references nd_protocol (protocol_id) on delete cascade INITIALLY DEFERRED,
    reagent_id integer NOT NULL references nd_reagent (reagent_id) on delete cascade INITIALLY DEFERRED,
    type_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED
);


CREATE TABLE nd_protocolprop (
    protocolprop_id serial PRIMARY KEY NOT NULL,
    protocol_id integer NOT NULL references nd_protocol (protocol_id) on delete cascade INITIALLY DEFERRED,
    cvterm_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL,
    constraint protocolprop_c1 unique (protocol_id,cvterm_id,rank)
);

COMMENT ON TABLE nd_protocolprop IS 'Property/value associations for protocol.';

COMMENT ON COLUMN nd_protocolprop.protocol_id IS 'The protocol to which the property applies.';

COMMENT ON COLUMN nd_protocolprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN nd_protocolprop.value IS 'The value of the property.';

COMMENT ON COLUMN nd_protocolprop.rank IS 'The rank of the property value, if the property has an array of values.';



CREATE TABLE nd_assay_stock (
    assay_stock_id serial PRIMARY KEY NOT NULL,
    assay_id integer NOT NULL references nd_assay (assay_id) on delete cascade INITIALLY DEFERRED,
    stock_id integer NOT NULL references stock (stock_id)  on delete cascade INITIALLY DEFERRED,
    type_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE nd_assay_stock IS 'Part of a stock or a clone of a stock that is used in an assay';


COMMENT ON COLUMN nd_assay_stock.stock_id IS 'stock used in the extraction or the corresponding stock for the clone';


CREATE TABLE nd_assay_protocol (
    assay_protocol_id serial PRIMARY KEY NOT NULL,
    assay_id integer NOT NULL references nd_assay (assay_id) on delete cascade INITIALLY DEFERRED,
    protocol_id integer NOT NULL references nd_protocol (protocol_id) on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE nd_assay_protocol IS 'Linking table: assays to the protocols they involve.';


CREATE TABLE nd_assay_phenotype (
    assay_phenotype_id serial PRIMARY KEY NOT NULL,
    assay_id integer NOT NULL UNIQUE REFERENCES nd_assay (assay_id) on delete cascade INITIALLY DEFERRED,
    phenotype_id integer NOT NULL references phenotype (phenotype_id) on delete cascade INITIALLY DEFERRED
); 

COMMENT ON TABLE nd_assay_phenotype IS 'Linking table: assays to the phenotypes they produce. There is a one-to-one relationship between an assay and a phenotype since each phenotype record should point to one assay. Add a new assay_id for each phenotype record.';

CREATE TABLE nd_assay_genotype (
    assay_genotype_id serial PRIMARY KEY NOT NULL,
    assay_id integer NOT NULL UNIQUE references nd_assay (assay_id) on delete cascade INITIALLY DEFERRED,
    genotype_id integer NOT NULL references genotype (genotype_id) on delete cascade INITIALLY DEFERRED 
);

COMMENT ON TABLE nd_assay_genotype IS 'Linking table: assays to the genotypes they produce. There is a one-to-one relationship between an assay and a genotype since each genotype record should point to one assay. Add a new assay_id for each genotype record.';


CREATE TABLE nd_reagent_relationship (
    reagent_relationship_id serial PRIMARY KEY NOT NULL,
    subject_reagent_id integer NOT NULL references nd_reagent (reagent_id) on delete cascade INITIALLY DEFERRED,
    object_reagent_id integer NOT NULL  references nd_reagent (reagent_id) on delete cascade INITIALLY DEFERRED,
    type_id integer NOT NULL  references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE nd_reagent_relationship IS 'Relationships between reagents. Some reagents form a group. i.e., they are used all together or not at all. Examples are adapter/linker/enzyme assay reagents.';

COMMENT ON COLUMN nd_reagent_relationship.subject_reagent_id IS 'The subject reagent in the relationship. In parent/child terminology, the subject is the child. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

COMMENT ON COLUMN nd_reagent_relationship.object_reagent_id IS 'The object reagent in the relationship. In parent/child terminology, the object is the parent. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

COMMENT ON COLUMN nd_reagent_relationship.type_id IS 'The type (or predicate) of the relationship. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';


CREATE TABLE nd_reagentprop (
    reagentprop_id serial PRIMARY KEY NOT NULL,
    reagent_id integer NOT NULL references nd_reagent (reagent_id) on delete cascade INITIALLY DEFERRED,
    cvterm_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL,
    constraint reagentprop_c1 unique (reagent_id,cvterm_id,rank)
);

CREATE TABLE nd_assay_stockprop (
    assay_stockprop_id serial PRIMARY KEY NOT NULL,
    assay_stock_id integer NOT NULL references nd_assay_stock (assay_stock_id) on delete cascade INITIALLY DEFERRED,
    cvterm_id integer NOT NULL references cvterm (cvterm_id) on delete cascade INITIALLY DEFERRED,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL,
    constraint assay_stockprop_c1 unique (assay_stock_id,cvterm_id,rank)
);

COMMENT ON TABLE nd_assay_stockprop IS 'Property/value associations for assay_stocks. This table can store the properties such as treatment';

COMMENT ON COLUMN nd_assay_stockprop.assay_stock_id IS 'The assay_stock to which the property applies.';

COMMENT ON COLUMN nd_assay_stockprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN nd_assay_stockprop.value IS 'The value of the property.';

COMMENT ON COLUMN nd_assay_stockprop.rank IS 'The rank of the property value, if the property has an array of values.';


CREATE TABLE nd_assay_stock_dbxref (
    assay_stock_dbxref_id serial PRIMARY KEY NOT NULL,
    assay_stock_id integer NOT NULL references nd_assay_stock (assay_stock_id) on delete cascade INITIALLY DEFERRED,
    dbxref_id integer NOT NULL references dbxref (dbxref_id) on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE nd_assay_stock_dbxref IS 'Cross-reference assay_stock to accessions, images, etc';



CREATE TABLE nd_assay_dbxref (
    assay_dbxref_id serial PRIMARY KEY NOT NULL,
    assay_id integer NOT NULL references nd_assay (assay_id) on delete cascade INITIALLY DEFERRED,
    dbxref_id integer NOT NULL references dbxref (dbxref_id) on delete cascade INITIALLY DEFERRED
);

COMMENT ON TABLE nd_assay_dbxref IS 'Cross-reference assay to accessions, images, etc';


