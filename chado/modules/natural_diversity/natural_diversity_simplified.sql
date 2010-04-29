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

CREATE TABLE nd_diversityexperiment (
    diversityexperiment_id integer NOT NULL,
    geolocation_id integer NOT NULL,
    stocksample_id integer NOT NULL,
    date timestamp with timezone 
);

CREATE SEQUENCE nd_diversityexperiment_diversityexperiment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_diversityexperiment_diversityexperiment_id_seq OWNED BY nd_diversityexperiment.diversityexperiment_id;

CREATE TABLE nd_diversityexperiment_project (
    diversityexperiment_project_id integer NOT NULL,
    project_id integer NOT NULL,
    diversityexperiment_id integer NOT NULL
);

CREATE TABLE nd_diversityexperimentprop (
    diversityexperimentprop_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255) NOT NULL,
    rank integer NOT NULL,
    diversityexperiment_id integer NOT NULL
);

-- this probably needs some work, depending on how cross-database we
-- want to be.  In Postgres, at least, there are much better ways to 
-- represent geo information.

CREATE TABLE nd_geolocation (
    geolocation_id integer NOT NULL,
    description character varying(255),
    coordinate_xml character varying(1024),
    latitude real,
    longitude real,
    geodetic_datum character varying(32),
    altitude real,
    altitude_dev real,
    postalcode character varying(32),
    county character varying(64),
    province character varying(64),
    country character varying(64)
);

COMMENT ON TABLE nd_geolocation IS 'The geo-referencable location of the stock. NOTE: This entity is subject to change as a more general and possibly more OpenGIS-compliant geolocation module may be introduced into Chado.';

COMMENT ON COLUMN nd_geolocation.description IS 'A textual representation of the location, if this is the original georeference. Optional if the original georeference is available in lat/long coordinates.';

COMMENT ON COLUMN nd_geolocation.coordinate_xml IS 'The georeference in XML format, preferably in GML.';

COMMENT ON COLUMN nd_geolocation.latitude IS 'The decimal latitude coordinate of the georeference, using positive and negative sign to indicate N and S, respectively.';

COMMENT ON COLUMN nd_geolocation.longitude IS 'The decimal longitude coordinate of the georeference, using positive and negative sign to indicate E and W, respectively.';

COMMENT ON COLUMN nd_geolocation.geodetic_datum IS 'The geodetic system on which the geo-reference coordinates are based. For geo-references measured between 1984 and 2010, this will typically be WGS84.';

COMMENT ON COLUMN nd_geolocation.altitude IS 'The altitude (elevation) of the location in meters. If the altitude is only known as a range, this is the average, and altitude_dev will hold half of the width of the range.';

COMMENT ON COLUMN nd_geolocation.altitude_dev IS 'The possible deviation in altitude, in meters, from the average altitude for collected individuals. Will be empty (null) if the altitude is exact.';

COMMENT ON COLUMN nd_geolocation.postalcode IS 'The postal code, or zipcode in the US, within which the georeference falls.';

COMMENT ON COLUMN nd_geolocation.county IS 'The county (or equivalent local government unit) whithin which the georeference falls. This should probably rather be a foreign key to a cvterm, but there is an unresolved problem about the univocality constraint with location name ontologies, such as the Gazetteer.';

COMMENT ON COLUMN nd_geolocation.province IS 'The province, or state, within which the georeference falls. This should probably rather be a foreign key to a cvterm, but there is an unresolved problem about the univocality constraint with location name ontologies, such as the Gazetteer.';

COMMENT ON COLUMN nd_geolocation.country IS 'The country within which the georeference falls. This should probably rather be a foreign key to a cvterm, but there is an unresolved problem about the univocality constraint with location name ontologies, such as the Gazetteer.';

CREATE SEQUENCE nd_geolocation_geolocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_geolocation_geolocation_id_seq OWNED BY nd_geolocation.geolocation_id;

CREATE TABLE nd_geolocationprop (
    geolocationprop_id integer NOT NULL,
    geolocation_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(250) NOT NULL,
    rank integer NOT NULL
);

COMMENT ON TABLE nd_geolocationprop IS 'Property/value associations for geolocations. This table can store the properties such as location and environment';

COMMENT ON COLUMN nd_geolocationprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN nd_geolocationprop.value IS 'The value of the property.';

COMMENT ON COLUMN nd_geolocationprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE nd_geolocationprop_geolocationprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_geolocationprop_geolocationprop_id_seq OWNED BY nd_geolocationprop.geolocationprop_id;

CREATE TABLE nd_assay (
    assay_id integer NOT NULL,
    name character varying(255) NOT NULL
);

COMMENT ON TABLE nd_assay IS 'An assay can be anything that is done as part of the experiment.';

COMMENT ON COLUMN nd_assay.name IS 'The assay name.';

CREATE SEQUENCE nd_assay_assay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_assay_assay_id_seq OWNED BY nd_assay.assay_id;

CREATE TABLE nd_assay_reagent (
    assay_reagent_id integer NOT NULL,
    assay_id integer NOT NULL,
    reagent_id integer NOT NULL,
    type_id integer NOT NULL
);

CREATE TABLE nd_assayprop (
    assayprop_id integer NOT NULL,
    assay_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL
);

COMMENT ON TABLE nd_assayprop IS 'Property/value associations for assays.';

COMMENT ON COLUMN nd_assayprop.assay_id IS 'The assay to which the property applies.';

COMMENT ON COLUMN nd_assayprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN nd_assayprop.value IS 'The value of the property.';

COMMENT ON COLUMN nd_assayprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE nd_assayprop_assayprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_assayprop_assayprop_id_seq OWNED BY nd_assayprop.assayprop_id;

CREATE TABLE nd_diversityexperiment_phenotype (
    diversityexperiment_phenotype_id integer NOT NULl,
    diversityexperiment_id integer NOT NULL,
    phenotype_id integer NOT NULL,
    assay_id integer
);

COMMENT ON TABLE nd_diversityexperiment_phenotype IS 'Linking table: diversityexperiments to the phenotypes they produce.';

CREATE TABLE nd_diversityexperiment_genotype (
    diversityexperiment_genotype_id integer NOT NULL,
    diversityexperiment_id integer NOT NULL,
    genotype_id integer NOT NULL,
    assay_id integer
);

COMMENT ON TABLE nd_diversityexperiment_genotype IS 'Linking table: diversityexperiments to the genotypes they produce.';

CREATE TABLE nd_diversityexperiment_assay (
    diversityexperiment_assay_id integer NOT NULL,
    assay_id integer NOT NULL,
    diversityexperiment_id integer NOT NULL
);

COMMENT ON TABLE nd_diversityexperiment_assay IS 'Linking table: diversityexperiments to the assays they involve.';

CREATE TABLE nd_reagent (
    reagent_id integer NOT NULL,
    name character varying(80) NOT NULL,
    type_id integer NOT NULL,
    feature_id integer
);

COMMENT ON TABLE nd_reagent IS 'A reagent such as a primer, an enzyme, an adapter oligo, a linker oligo. Reagents are used in genotyping assays, or in any other kind of assay.';

COMMENT ON COLUMN nd_reagent.name IS 'The name of the reagent. The name should be unique for a given type.';

COMMENT ON COLUMN nd_reagent.type_id IS 'The type of the reagent, for example linker oligomer, or forward primer.';

COMMENT ON COLUMN nd_reagent.feature_id IS 'If the reagent is a primer, the feature that it corresponds to. More generally, the corresponding feature for any reagent that has a sequence that maps to another sequence.';

CREATE SEQUENCE nd_reagent_reagent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_reagent_reagent_id_seq OWNED BY nd_reagent.reagent_id;

CREATE TABLE nd_reagent_relationship (
    reagent_relationship_id integer NOT NULL,
    subject_reagent_id integer NOT NULL,
    object_reagent_id integer NOT NULL,
    type_id integer NOT NULL
);

COMMENT ON TABLE nd_reagent_relationship IS 'Relationships between reagents. Some reagents form a group; i.e., they are used all together or not at all. Examples are adapter/linker/enzyme assay reagents.';

COMMENT ON COLUMN nd_reagent_relationship.subject_reagent_id IS 'The subject reagent in the relationship. In parent/child terminology, the subject is the child. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

COMMENT ON COLUMN nd_reagent_relationship.object_reagent_id IS 'The object reagent in the relationship. In parent/child terminology, the object is the parent. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

COMMENT ON COLUMN nd_reagent_relationship.type_id IS 'The type (or predicate) of the relationship. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

CREATE SEQUENCE nd_reagent_relationship_reagent_relationship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_reagent_relationship_reagent_relationship_id_seq OWNED BY nd_reagent_relationship.reagent_relationship_id;

CREATE TABLE nd_stocksample (
    stocksample_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    identifier character varying(255),
    stock_id integer NOT NULL
);

COMMENT ON TABLE nd_stocksample IS 'Part of a stock or a clone of a stock that is used in an experiment';

COMMENT ON COLUMN nd_stocksample.name IS 'Reference name for the stocksample, for tree breeding data, it may be composed of stock, orchard, and plot names. When the stocksample data is not relevant or not available, the name of the stock can be stored here.';

COMMENT ON COLUMN nd_stocksample.description IS 'Description of the stocksample including information on stocksample quality, e.g. concentration, purity, etc.';

COMMENT ON COLUMN nd_stocksample.identifier IS 'Identifier, for example a barcode, of the stocksample';

COMMENT ON COLUMN nd_stocksample.stock_id IS 'stock used in the extraction or the corresponding stock for the clone';

CREATE SEQUENCE nd_stocksample_stocksample_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_stocksample_stocksample_id_seq OWNED BY nd_stocksample.stocksample_id;

CREATE TABLE nd_stocksampleprop (
    stocksampleprop_id integer NOT NULL,
    stocksample_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL
);

COMMENT ON TABLE nd_stocksampleprop IS 'Property/value associations for stocksamples. This table can store the properties such as treatment';

COMMENT ON COLUMN nd_stocksampleprop.stocksample_id IS 'The stocksample to which the property applies.';

COMMENT ON COLUMN nd_stocksampleprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN nd_stocksampleprop.value IS 'The value of the property.';

COMMENT ON COLUMN nd_stocksampleprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE nd_stocksampleprop_stocksampleprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE nd_stocksampleprop_stocksampleprop_id_seq OWNED BY nd_stocksampleprop.stocksampleprop_id;

CREATE TABLE nd_stocksample_dbxref (
    stocksample_dbxref_id integer NOT NULL,
    stocksample_id integer NOT NULL,
    dbxref_id integer NOT NULL
);

COMMENT ON TABLE nd_stocksample_dbxref IS 'Cross-reference stock samples to accessions, images, etc';

ALTER TABLE nd_diversityexperiment ALTER COLUMN diversityexperiment_id SET DEFAULT nextval('nd_diversityexperiment_diversityexperiment_id_seq'::regclass);

ALTER TABLE nd_geolocation ALTER COLUMN geolocation_id SET DEFAULT nextval('nd_geolocation_geolocation_id_seq'::regclass);

ALTER TABLE nd_geolocationprop ALTER COLUMN geolocationprop_id SET DEFAULT nextval('nd_geolocationprop_geolocationprop_id_seq'::regclass);

ALTER TABLE nd_assay ALTER COLUMN assay_id SET DEFAULT nextval('nd_assay_assay_id_seq'::regclass);

ALTER TABLE nd_assayprop ALTER COLUMN assayprop_id SET DEFAULT nextval('nd_assayprop_assayprop_id_seq'::regclass);

ALTER TABLE nd_reagent ALTER COLUMN reagent_id SET DEFAULT nextval('nd_reagent_reagent_id_seq'::regclass);

ALTER TABLE nd_reagent_relationship ALTER COLUMN reagent_relationship_id SET DEFAULT nextval('nd_reagent_relationship_reagent_relationship_id_seq'::regclass);

ALTER TABLE nd_stocksample ALTER COLUMN stocksample_id SET DEFAULT nextval('nd_stocksample_stocksample_id_seq'::regclass);

ALTER TABLE nd_stocksampleprop ALTER COLUMN stocksampleprop_id SET DEFAULT nextval('nd_stocksampleprop_stocksampleprop_id_seq'::regclass);

ALTER TABLE ONLY nd_diversityexperiment_project
    ADD CONSTRAINT nd_assay_keydiversityexperiment_project_id PRIMARY KEY (diversityexperiment_project_id);

ALTER TABLE ONLY nd_diversityexperiment
    ADD CONSTRAINT nd_assay_keyexperiment_id PRIMARY KEY (diversityexperiment_id);

ALTER TABLE ONLY nd_diversityexperimentprop
    ADD CONSTRAINT nd_assay_keydiversityexperimentprop_id PRIMARY KEY (diversityexperimentprop_id);

ALTER TABLE ONLY nd_geolocation
    ADD CONSTRAINT nd_assay_keygeolocation_pkey PRIMARY KEY (geolocation_id);

ALTER TABLE ONLY nd_geolocationprop
    ADD CONSTRAINT nd_assay_keygeolocationprop_id PRIMARY KEY (geolocationprop_id);

ALTER TABLE ONLY nd_assay
    ADD CONSTRAINT nd_assay_keyassay_pkey PRIMARY KEY (assay_id);

ALTER TABLE ONLY nd_assay_reagent
    ADD CONSTRAINT nd_assay_keyassay_reagent_pk PRIMARY KEY (assay_reagent_id);

ALTER TABLE ONLY nd_assayprop
    ADD CONSTRAINT nd_assay_keyassayprop_pkey PRIMARY KEY (assayprop_id);

ALTER TABLE ONLY nd_reagent
    ADD CONSTRAINT nd_assay_keyreagent_pkey PRIMARY KEY (reagent_id);

ALTER TABLE ONLY nd_reagent_relationship
    ADD CONSTRAINT nd_assay_keyreagent_relationship_pkey PRIMARY KEY (reagent_relationship_id);

ALTER TABLE ONLY nd_stocksample_dbxref
    ADD CONSTRAINT nd_stocksample_dbxref_pkey PRIMARY KEY (stocksample_dbxref_id);

ALTER TABLE ONLY nd_stocksample
    ADD CONSTRAINT nd_assay_keystocksample_pkey PRIMARY KEY (stocksample_id);

ALTER TABLE ONLY nd_stocksampleprop
    ADD CONSTRAINT nd_assay_keystocksampleprop_pkey PRIMARY KEY (stocksampleprop_id);

CREATE UNIQUE INDEX assay_name_key ON nd_assay USING btree (name);

CREATE UNIQUE INDEX nd_assayprop_c1 ON nd_assayprop USING btree (assay_id, cvterm_id, rank);

CREATE UNIQUE INDEX nd_reagent_c1 ON nd_reagent USING btree (name, type_id);

CREATE UNIQUE INDEX nd_reagent_relationship_c1 ON nd_reagent_relationship USING btree (subject_reagent_id, object_reagent_id, type_id);

CREATE UNIQUE INDEX nd_stocksample_c1 ON nd_stocksample USING btree (name);

CREATE UNIQUE INDEX nd_stocksampleprop_c1 ON nd_stocksampleprop USING btree (stocksample_id, cvterm_id, rank);

ALTER TABLE ONLY nd_diversityexperiment
    ADD CONSTRAINT nd_assay_keydiversityexperiment_geolocation_fk FOREIGN KEY (geolocation_id) REFERENCES nd_geolocation(geolocation_id);

ALTER TABLE ONLY nd_diversityexperiment_phenotype
    ADD CONSTRAINT nd_diversityexperiment_phenotype_diversityexperiment_id_fk FOREIGN KEY (diversityexperiment_id) REFERENCES nd_diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY nd_diversityexperiment_genotype
    ADD CONSTRAINT nd_diversityexperiment_genotype_diversityexperiment_id_fk FOREIGN KEY (diversityexperiment_id) REFERENCES nd_diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY nd_diversityexperiment_assay
    ADD CONSTRAINT nd_diversityexperiment_assay_diversityexperiment_id_fk FOREIGN KEY (diversityexperiment_id) REFERENCES nd_diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY nd_diversityexperiment_assay
    ADD CONSTRAINT nd_diversityexperiment_assay_assay_id_fk FOREIGN KEY (assay_id) REFERENCES nd_assay(assay_id);

ALTER TABLE ONLY nd_diversityexperiment_project
    ADD CONSTRAINT nd_assay_keydiversityexperiment_diversityexperiment_project_fk FOREIGN KEY (diversityexperiment_id) REFERENCES nd_diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY nd_diversityexperimentprop
    ADD CONSTRAINT nd_assay_keydiversityexperiment_diversityexperimentprop_fk FOREIGN KEY (diversityexperiment_id) REFERENCES nd_diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY nd_geolocationprop
    ADD CONSTRAINT nd_assay_keygeolocation_geolocationprop_fk FOREIGN KEY (geolocation_id) REFERENCES nd_geolocation(geolocation_id);

ALTER TABLE ONLY nd_assayprop
    ADD CONSTRAINT nd_assay_keyassayprop_assay_id_fkey FOREIGN KEY (assay_id) REFERENCES nd_assay(assay_id) ON DELETE CASCADE;

ALTER TABLE ONLY nd_assay_reagent
    ADD CONSTRAINT nd_assay_keyreagent_new_table_fk FOREIGN KEY (reagent_id) REFERENCES nd_reagent(reagent_id);

ALTER TABLE ONLY nd_assay_reagent
    ADD CONSTRAINT nd_assay_reagent_nd_assay_id_fk FOREIGN KEY (assay_id) REFERENCES nd_assay(assay_id);

ALTER TABLE ONLY nd_reagent_relationship
    ADD CONSTRAINT nd_assay_keyreagent_relationship_object_reagent_id_fkey FOREIGN KEY (object_reagent_id) REFERENCES nd_reagent(reagent_id) ON DELETE CASCADE;

ALTER TABLE ONLY nd_reagent_relationship
    ADD CONSTRAINT nd_assay_keyreagent_relationship_subject_reagent_id_fkey FOREIGN KEY (subject_reagent_id) REFERENCES nd_reagent(reagent_id) ON DELETE CASCADE;

ALTER TABLE ONLY nd_stocksample_dbxref
    ADD CONSTRAINT nd_stocksample_dbxref_keydbxref_dbxref_id_fkey FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE;

ALTER TABLE ONLY nd_stocksample_dbxref
    ADD CONSTRAINT nd_stocksample_dbxref_stocksample_id_fk FOREIGN KEY (stocksample_id) REFERENCES nd_stocksample(stocksample_id) ON DELETE CASCADE;

ALTER TABLE ONLY nd_diversityexperiment
    ADD CONSTRAINT nd_assay_keystocksample_diversityexperiment_fk FOREIGN KEY (stocksample_id) REFERENCES nd_stocksample(stocksample_id);

ALTER TABLE ONLY nd_stocksampleprop
    ADD CONSTRAINT nd_assay_keystocksampleprop_stocksample_id_fkey FOREIGN KEY (stocksample_id) REFERENCES nd_stocksample(stocksample_id) ON DELETE CASCADE;

