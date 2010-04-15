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



CREATE TABLE crossexperiment (
    diversityexperiment_id integer NOT NULL,
    name character varying(255) NOT NULL,
    expdate date,
    type_id integer NOT NULL
);

COMMENT ON COLUMN crossexperiment.name IS 'Reference name for the cross, also known as the "brood name." Existing conventions for naming the cross use the "stock" type, listing the female "type" first. Thus, a backcross of a female F1 individual generated from a cross between a female H. erato cyrbia and a male H. himera by a male H. himera would be (HecHh)xHh_001, where 001 is the first replicate of this type of cross.';
COMMENT ON COLUMN crossexperiment.expdate IS 'The date of the cross experiment, typically the mating date.';
COMMENT ON COLUMN crossexperiment.type_id IS 'The type of cross, for example, F1, or F2, or backcross.';

CREATE TABLE crossexperiment_stock (
    crossexperiment_stock_id integer NOT NULL,
    stock_id integer NOT NULL,
    type_id integer NOT NULL,
    diversityexperiment_id integer NOT NULL
);

COMMENT ON TABLE crossexperiment_stock IS 'The parental stock(s) used in a crossexperiment. Some cross experiments are carried out by pairing multiple males to one or multiple female(s) so that the actual parent stocks of offspring may not necessarily be known a-priori. ';
COMMENT ON COLUMN crossexperiment_stock.stock_id IS 'The parental stock being used in the cross experiment. A specific stock can be associated with a crossexperiment only once. There may be multiple parental stocks of the same type in a cross experiment.';
COMMENT ON COLUMN crossexperiment_stock.type_id IS 'The type of the association of the stock, such as ''maternal parent'', or ''paternal parent''. Note that this is not necessarily redundant with the gender of the stock, for example consider plants.';

CREATE SEQUENCE crossexperiment_stock_crossexperiment_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE crossexperiment_stock_crossexperiment_stock_id_seq OWNED BY crossexperiment_stock.crossexperiment_stock_id;


CREATE TABLE diversityexperiment (
    diversityexperiment_id integer NOT NULL,
    assay_date date NOT NULL,
    experimenter_id integer NOT NULL,
    notes character varying(255) NOT NULL,
    geolocation_id integer NOT NULL,
    stocksample_id integer NOT NULL
);

CREATE SEQUENCE diversityexperiment_diversityexperiment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE diversityexperiment_diversityexperiment_id_seq OWNED BY diversityexperiment.diversityexperiment_id;

CREATE TABLE diversityexperiment_project (
    diversityexperiment_project_id integer NOT NULL,
    project_id integer NOT NULL,
    diversityexperiment_id integer NOT NULL
);

CREATE TABLE feature_gtassay (
    feature_gtassay_id integer NOT NULL,
    feature_id integer NOT NULL,
    gtassay_id integer NOT NULL
);

CREATE SEQUENCE feature_gtassay_feature_gtassay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE feature_gtassay_feature_gtassay_id_seq OWNED BY feature_gtassay.feature_gtassay_id;

CREATE TABLE fieldcollection (
    diversityexperiment_id integer NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone NOT NULL,
    time_of_day character varying(10),
    collection_size integer NOT NULL
);

CREATE TABLE diversityexperimentprop (
    diversityexperimentprop_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255) NOT NULL,
    rank integer NOT NULL,
    diversityexperiment_id integer NOT NULL
);

CREATE TABLE geolocation (
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

COMMENT ON TABLE geolocation IS 'The geo-referencable location of the stock. NOTE: This entity is subject to change as a more general and possibly more OpenGIS-compliant geolocation module may be introduced into Chado.';

COMMENT ON COLUMN geolocation.description IS 'A textual representation of the location, if this is the original georeference. Optional if the original georeference is available in lat/long coordinates.';

COMMENT ON COLUMN geolocation.coordinate_xml IS 'The georeference in XML format, preferably in GML.';

COMMENT ON COLUMN geolocation.latitude IS 'The decimal latitude coordinate of the georeference, using positive and negative sign to indicate N and S, respectively.';

COMMENT ON COLUMN geolocation.longitude IS 'The decimal longitude coordinate of the georeference, using positive and negative sign to indicate E and W, respectively.';

COMMENT ON COLUMN geolocation.geodetic_datum IS 'The geodetic system on which the geo-reference coordinates are based. For geo-references measured between 1984 and 2010, this will typically be WGS84.';

COMMENT ON COLUMN geolocation.altitude IS 'The altitude (elevation) of the location in meters. If the altitude is only known as a range, this is the average, and altitude_dev will hold half of the width of the range.';

COMMENT ON COLUMN geolocation.altitude_dev IS 'The possible deviation in altitude, in meters, from the average altitude for collected individuals. Will be empty (null) if the altitude is exact.';

COMMENT ON COLUMN geolocation.postalcode IS 'The postal code, or zipcode in the US, within which the georeference falls.';

COMMENT ON COLUMN geolocation.county IS 'The county (or equivalent local government unit) whithin which the georeference falls. This should probably rather be a foreign key to a cvterm, but there is an unresolved problem about the univocality constraint with location name ontologies, such as the Gazetteer.';

COMMENT ON COLUMN geolocation.province IS 'The province, or state, within which the georeference falls. This should probably rather be a foreign key to a cvterm, but there is an unresolved problem about the univocality constraint with location name ontologies, such as the Gazetteer.';

COMMENT ON COLUMN geolocation.country IS 'The country within which the georeference falls. This should probably rather be a foreign key to a cvterm, but there is an unresolved problem about the univocality constraint with location name ontologies, such as the Gazetteer.';

CREATE SEQUENCE geolocation_geolocation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE geolocation_geolocation_id_seq OWNED BY geolocation.geolocation_id;

CREATE TABLE geolocationprop (
    geolocationprop_id integer NOT NULL,
    geolocation_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(250) NOT NULL,
    rank integer NOT NULL
);

COMMENT ON TABLE geolocationprop IS 'Property/value associations for geolocations. This table can store the properties such as location and environment';

COMMENT ON COLUMN geolocationprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN geolocationprop.value IS 'The value of the property.';

COMMENT ON COLUMN geolocationprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE geolocationprop_geolocationprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE geolocationprop_geolocationprop_id_seq OWNED BY geolocationprop.geolocationprop_id;

CREATE TABLE gtassay (
    gtassay_id integer NOT NULL,
    name character varying(255) NOT NULL,
    species_id integer,
    image_id integer,
    type_id integer
);

COMMENT ON TABLE gtassay IS 'Genotyping assay, or method of polymorphism detection.';

COMMENT ON COLUMN gtassay.name IS 'Reference name of the genotyping assay';

COMMENT ON COLUMN gtassay.species_id IS 'The species on which the assay was first validated; this need not be the same as the one from which the specimen was obtained that is used in the genotyping experiment.';

COMMENT ON COLUMN gtassay.image_id IS 'The image documenting the quality and/or success of the assay; typically this will be a gel image, for example showing the purity of bands.';

COMMENT ON COLUMN gtassay.type_id IS 'The type of the assay. Usually this is the method of scoring the polymorphism (e.g., AFLP, SSCP, RFLP, size polymorphism).';

CREATE SEQUENCE gtassay_gtassay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE gtassay_gtassay_id_seq OWNED BY gtassay.gtassay_id;

CREATE TABLE gtassay_reagent (
    gtassay_reagent_id integer NOT NULL,
    gtassay_id integer NOT NULL,
    reagent_id integer NOT NULL,
    type_id integer NOT NULL
);

COMMENT ON TABLE gtassay_reagent IS 'Reagents used by a genotyping assay. An x may use multiple reagents.';

COMMENT ON COLUMN gtassay_reagent.gtassay_id IS 'The genotyping assay using the reagent.';

COMMENT ON COLUMN gtassay_reagent.reagent_id IS 'The reagent used by the genotyping assay.';

CREATE SEQUENCE gtassay_reagent_gtassay_reagent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE gtassay_reagent_gtassay_reagent_id_seq OWNED BY gtassay_reagent.gtassay_reagent_id;

CREATE TABLE gtassayprop (
    gtassayprop_id integer NOT NULL,
    gtassay_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL
);

COMMENT ON TABLE gtassayprop IS 'Property/value associations for genotyping assays.';

COMMENT ON COLUMN gtassayprop.gtassay_id IS 'The genotyping assay to which the property applies.';

COMMENT ON COLUMN gtassayprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN gtassayprop.value IS 'The value of the property.';

COMMENT ON COLUMN gtassayprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE gtassayprop_gtassayprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE gtassayprop_gtassayprop_id_seq OWNED BY gtassayprop.gtassayprop_id;

CREATE TABLE gtexperiment (
    diversityexperiment_id integer NOT NULL,
    collection_date date NOT NULL,
    gtassay_id integer NOT NULL,
    genotype_id integer NOT NULL
);

COMMENT ON COLUMN gtexperiment.collection_date IS 'Date that the sample was collected';

COMMENT ON COLUMN gtexperiment.gtassay_id IS 'The genotyping assay used to determine the genotype.';

COMMENT ON COLUMN gtexperiment.genotype_id IS 'The genotype determined by the experiment.';

CREATE TABLE image (
    image_id integer NOT NULL,
    identifier character varying(255),
    uri character varying(1024) NOT NULL
);

COMMENT ON TABLE image IS 'Link to an external image';

COMMENT ON COLUMN image.identifier IS 'Unique identifier for the image, such as a LSID, or any other GUID';

COMMENT ON COLUMN image.uri IS 'URL or local file path to image';

CREATE SEQUENCE image_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE image_image_id_seq OWNED BY image.image_id;

CREATE TABLE ptassay (
    ptassay_id integer NOT NULL,
    name character varying(255) NOT NULL
);

COMMENT ON TABLE ptassay IS 'Phenotype determination assay';

COMMENT ON COLUMN ptassay.name IS 'Reference name of the phenotyping assay';

CREATE SEQUENCE ptassay_ptassay_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE ptassay_ptassay_id_seq OWNED BY ptassay.ptassay_id;

CREATE TABLE ptassay_reagent (
    ptassay_reagent_id integer NOT NULL,
    ptassay_id integer NOT NULL,
    reagent_id integer NOT NULL,
    type_id integer NOT NULL
);

CREATE TABLE ptassayprop (
    ptassayprop_id integer NOT NULL,
    ptassay_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL
);

COMMENT ON TABLE ptassayprop IS 'Property/value associations for phenotyping assays.';

COMMENT ON COLUMN ptassayprop.ptassay_id IS 'The phenotyping assay to which the property applies.';

COMMENT ON COLUMN ptassayprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN ptassayprop.value IS 'The value of the property.';

COMMENT ON COLUMN ptassayprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE ptassayprop_ptassayprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE ptassayprop_ptassayprop_id_seq OWNED BY ptassayprop.ptassayprop_id;

CREATE TABLE ptexperiment (
    diversityexperiment_id integer NOT NULL,
    collection_date date NOT NULL,
    ptassay_id integer NOT NULL,
    phenotype_id integer NOT NULL,
    ptassay_reagent_id integer NOT NULL
);

COMMENT ON COLUMN ptexperiment.collection_date IS 'Date that the sample was collected';

COMMENT ON COLUMN ptexperiment.ptassay_id IS 'The phenotyping assay used to determine the phenotype.';

COMMENT ON COLUMN ptexperiment.phenotype_id IS 'The phenotype determined by the experiment.';

CREATE TABLE reagent (
    reagent_id integer NOT NULL,
    name character varying(80) NOT NULL,
    type_id integer NOT NULL,
    feature_id integer
);

COMMENT ON TABLE reagent IS 'A reagent such as a primer, an enzyme, an adapter oligo, a linker oligo. Reagents are used in genotyping assays, or in any other kind of assay.';

COMMENT ON COLUMN reagent.name IS 'The name of the reagent. The name should be unique for a given type.';

COMMENT ON COLUMN reagent.type_id IS 'The type of the reagent, for example linker oligomer, or forward primer.';

COMMENT ON COLUMN reagent.feature_id IS 'If the reagent is a primer, the feature that it corresponds to. More generally, the corresponding feature for any reagent that has a sequence that maps to another sequence.';

CREATE SEQUENCE reagent_reagent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE reagent_reagent_id_seq OWNED BY reagent.reagent_id;

CREATE TABLE reagent_relationship (
    reagent_relationship_id integer NOT NULL,
    subject_reagent_id integer NOT NULL,
    object_reagent_id integer NOT NULL,
    type_id integer NOT NULL
);

COMMENT ON TABLE reagent_relationship IS 'Relationships between reagents. Some reagents form a group; i.e., they are used all together or not at all. Examples are adapter/linker/enzyme assay reagents.';

COMMENT ON COLUMN reagent_relationship.subject_reagent_id IS 'The subject reagent in the relationship. In parent/child terminology, the subject is the child. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

COMMENT ON COLUMN reagent_relationship.object_reagent_id IS 'The object reagent in the relationship. In parent/child terminology, the object is the parent. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

COMMENT ON COLUMN reagent_relationship.type_id IS 'The type (or predicate) of the relationship. For example, in "linkerA 3prime-overhang-linker enzymeA" linkerA is the subject, 3prime-overhand-linker is the type, and enzymeA is the object.';

CREATE SEQUENCE reagent_relationship_reagent_relationship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE reagent_relationship_reagent_relationship_id_seq OWNED BY reagent_relationship.reagent_relationship_id;

CREATE TABLE stock_image (
    stock_image_id integer NOT NULL,
    stock_id integer NOT NULL,
    image_id integer NOT NULL
);

CREATE SEQUENCE stock_image_stock_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE stock_image_stock_image_id_seq OWNED BY stock_image.stock_image_id;

CREATE TABLE stocksample (
    stocksample_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    identifier character varying(255),
    stock_id integer NOT NULL
);

COMMENT ON TABLE stocksample IS 'Part of a stock or a clone of a stock that is used in an experiment';

COMMENT ON COLUMN stocksample.name IS 'Reference name for the stocksample, for tree breeding data, it may be composed of stock, orchard, and plot names. When the stocksample data is not relevant or not available, the name of the stock can be stored here.';

COMMENT ON COLUMN stocksample.description IS 'Description of the stocksample including information on stocksample quality, e.g. concentration, purity, etc.';

COMMENT ON COLUMN stocksample.identifier IS 'Identifier, for example a barcode, of the stocksample';

COMMENT ON COLUMN stocksample.stock_id IS 'stock used in the extraction or the corresponding stock for the clone';

CREATE SEQUENCE stocksample_stocksample_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE stocksample_stocksample_id_seq OWNED BY stocksample.stocksample_id;

CREATE TABLE stocksampleprop (
    stocksampleprop_id integer NOT NULL,
    stocksample_id integer NOT NULL,
    cvterm_id integer NOT NULL,
    value character varying(255),
    rank integer DEFAULT 0 NOT NULL
);

COMMENT ON TABLE stocksampleprop IS 'Property/value associations for stocksamples. This table can store the properties such as treatment';

COMMENT ON COLUMN stocksampleprop.stocksample_id IS 'The stocksample to which the property applies.';

COMMENT ON COLUMN stocksampleprop.cvterm_id IS 'The name of the property as a reference to a controlled vocabulary term.';

COMMENT ON COLUMN stocksampleprop.value IS 'The value of the property.';

COMMENT ON COLUMN stocksampleprop.rank IS 'The rank of the property value, if the property has an array of values.';

CREATE SEQUENCE stocksampleprop_stocksampleprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE stocksampleprop_stocksampleprop_id_seq OWNED BY stocksampleprop.stocksampleprop_id;

ALTER TABLE crossexperiment_stock ALTER COLUMN crossexperiment_stock_id SET DEFAULT nextval('crossexperiment_stock_crossexperiment_stock_id_seq'::regclass);


ALTER TABLE diversityexperiment ALTER COLUMN diversityexperiment_id SET DEFAULT nextval('diversityexperiment_diversityexperiment_id_seq'::regclass);

ALTER TABLE feature_gtassay ALTER COLUMN feature_gtassay_id SET DEFAULT nextval('feature_gtassay_feature_gtassay_id_seq'::regclass);

ALTER TABLE geolocation ALTER COLUMN geolocation_id SET DEFAULT nextval('geolocation_geolocation_id_seq'::regclass);

ALTER TABLE geolocationprop ALTER COLUMN geolocationprop_id SET DEFAULT nextval('geolocationprop_geolocationprop_id_seq'::regclass);

ALTER TABLE gtassay ALTER COLUMN gtassay_id SET DEFAULT nextval('gtassay_gtassay_id_seq'::regclass);

ALTER TABLE gtassay_reagent ALTER COLUMN gtassay_reagent_id SET DEFAULT nextval('gtassay_reagent_gtassay_reagent_id_seq'::regclass);

ALTER TABLE gtassayprop ALTER COLUMN gtassayprop_id SET DEFAULT nextval('gtassayprop_gtassayprop_id_seq'::regclass);

ALTER TABLE image ALTER COLUMN image_id SET DEFAULT nextval('image_image_id_seq'::regclass);

ALTER TABLE ptassay ALTER COLUMN ptassay_id SET DEFAULT nextval('ptassay_ptassay_id_seq'::regclass);

ALTER TABLE ptassayprop ALTER COLUMN ptassayprop_id SET DEFAULT nextval('ptassayprop_ptassayprop_id_seq'::regclass);

ALTER TABLE reagent ALTER COLUMN reagent_id SET DEFAULT nextval('reagent_reagent_id_seq'::regclass);

ALTER TABLE reagent_relationship ALTER COLUMN reagent_relationship_id SET DEFAULT nextval('reagent_relationship_reagent_relationship_id_seq'::regclass);

ALTER TABLE stock_image ALTER COLUMN stock_image_id SET DEFAULT nextval('stock_image_stock_image_id_seq'::regclass);

ALTER TABLE stocksample ALTER COLUMN stocksample_id SET DEFAULT nextval('stocksample_stocksample_id_seq'::regclass);

ALTER TABLE stocksampleprop ALTER COLUMN stocksampleprop_id SET DEFAULT nextval('stocksampleprop_stocksampleprop_id_seq'::regclass);

ALTER TABLE ONLY crossexperiment
    ADD CONSTRAINT crossexperiment_pkey PRIMARY KEY (diversityexperiment_id);

ALTER TABLE ONLY crossexperiment_stock
    ADD CONSTRAINT crossexperiment_stock_pkey PRIMARY KEY (crossexperiment_stock_id);


ALTER TABLE ONLY diversityexperiment_project
    ADD CONSTRAINT diversityexperiment_project_id PRIMARY KEY (diversityexperiment_project_id);

ALTER TABLE ONLY diversityexperiment
    ADD CONSTRAINT experiment_id PRIMARY KEY (diversityexperiment_id);

ALTER TABLE ONLY feature_gtassay
    ADD CONSTRAINT feature_gtassay_pkey PRIMARY KEY (feature_gtassay_id);

ALTER TABLE ONLY fieldcollection
    ADD CONSTRAINT fieldcollection_id PRIMARY KEY (diversityexperiment_id);

ALTER TABLE ONLY diversityexperimentprop
    ADD CONSTRAINT diversityexperimentprop_id PRIMARY KEY (diversityexperimentprop_id);

ALTER TABLE ONLY geolocation
    ADD CONSTRAINT geolocation_pkey PRIMARY KEY (geolocation_id);

ALTER TABLE ONLY geolocationprop
    ADD CONSTRAINT geolocationprop_id PRIMARY KEY (geolocationprop_id);

ALTER TABLE ONLY gtassay
    ADD CONSTRAINT gtassay_pkey PRIMARY KEY (gtassay_id);

ALTER TABLE ONLY gtassay_reagent
    ADD CONSTRAINT gtassay_reagent_pkey PRIMARY KEY (gtassay_reagent_id);

ALTER TABLE ONLY gtassayprop
    ADD CONSTRAINT gtassayprop_pkey PRIMARY KEY (gtassayprop_id);

ALTER TABLE ONLY gtexperiment
    ADD CONSTRAINT gtexperiment_pkey PRIMARY KEY (diversityexperiment_id);

ALTER TABLE ONLY image
    ADD CONSTRAINT image_pkey PRIMARY KEY (image_id);

ALTER TABLE ONLY ptassay
    ADD CONSTRAINT ptassay_pkey PRIMARY KEY (ptassay_id);

ALTER TABLE ONLY ptassay_reagent
    ADD CONSTRAINT ptassay_reagent_pk PRIMARY KEY (ptassay_reagent_id);

ALTER TABLE ONLY ptassayprop
    ADD CONSTRAINT ptassayprop_pkey PRIMARY KEY (ptassayprop_id);

ALTER TABLE ONLY ptexperiment
    ADD CONSTRAINT ptexperiment_pkey PRIMARY KEY (diversityexperiment_id);

ALTER TABLE ONLY reagent
    ADD CONSTRAINT reagent_pkey PRIMARY KEY (reagent_id);

ALTER TABLE ONLY reagent_relationship
    ADD CONSTRAINT reagent_relationship_pkey PRIMARY KEY (reagent_relationship_id);

ALTER TABLE ONLY stock_image
    ADD CONSTRAINT stock_image_pkey PRIMARY KEY (stock_image_id);

ALTER TABLE ONLY stocksample
    ADD CONSTRAINT stocksample_pkey PRIMARY KEY (stocksample_id);

ALTER TABLE ONLY stocksampleprop
    ADD CONSTRAINT stocksampleprop_pkey PRIMARY KEY (stocksampleprop_id);

CREATE UNIQUE INDEX crossexperiment_c1 ON crossexperiment USING btree (name);

CREATE UNIQUE INDEX crossexperiment_stock_c1 ON crossexperiment_stock USING btree (stock_id);


CREATE UNIQUE INDEX feature_gtassay_c1 ON feature_gtassay USING btree (feature_id, gtassay_id);

CREATE UNIQUE INDEX gtassay_c1 ON gtassay USING btree (name);

CREATE UNIQUE INDEX gtassay_reagent_c1 ON gtassay_reagent USING btree (gtassay_id, reagent_id, type_id);

CREATE UNIQUE INDEX gtassayprop_c1 ON gtassayprop USING btree (gtassay_id, cvterm_id, rank);

CREATE UNIQUE INDEX gtexperiment_c1 ON gtexperiment USING btree (collection_date, gtassay_id, genotype_id);

CREATE UNIQUE INDEX image_c1 ON image USING btree (identifier);

CREATE UNIQUE INDEX image_c2 ON image USING btree (uri);

CREATE UNIQUE INDEX ptassay_name_key ON ptassay USING btree (name);

CREATE UNIQUE INDEX ptassayprop_c1 ON ptassayprop USING btree (ptassay_id, cvterm_id, rank);

CREATE UNIQUE INDEX ptexperiment_c1 ON ptexperiment USING btree (collection_date, ptassay_id, phenotype_id);

CREATE UNIQUE INDEX reagent_c1 ON reagent USING btree (name, type_id);

CREATE UNIQUE INDEX reagent_relationship_c1 ON reagent_relationship USING btree (subject_reagent_id, object_reagent_id, type_id);

CREATE UNIQUE INDEX stock_image_stock_id_key ON stock_image USING btree (stock_id, image_id);

CREATE UNIQUE INDEX stocksample_c1 ON stocksample USING btree (name);

CREATE UNIQUE INDEX stocksampleprop_c1 ON stocksampleprop USING btree (stocksample_id, cvterm_id, rank);

ALTER TABLE ONLY crossexperiment_stock
    ADD CONSTRAINT crossexperiment_crossexperiment_stock_fk FOREIGN KEY (diversityexperiment_id) REFERENCES crossexperiment(diversityexperiment_id);


ALTER TABLE ONLY crossexperiment
    ADD CONSTRAINT diversityexperiment_crossexperiment_fk FOREIGN KEY (diversityexperiment_id) REFERENCES diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY fieldcollection
    ADD CONSTRAINT diversityexperiment_fieldcollection_fk FOREIGN KEY (diversityexperiment_id) REFERENCES diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY diversityexperiment
    ADD CONSTRAINT diversityexperiment_geolocation_fk FOREIGN KEY (geolocation_id) REFERENCES geolocation(geolocation_id);

ALTER TABLE ONLY gtexperiment
    ADD CONSTRAINT diversityexperiment_gtexperiment_fk FOREIGN KEY (diversityexperiment_id) REFERENCES diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY ptexperiment
    ADD CONSTRAINT diversityexperiment_ptexperiment_fk FOREIGN KEY (diversityexperiment_id) REFERENCES diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY diversityexperiment_project
    ADD CONSTRAINT diversityexperiment_diversityexperiment_project_fk FOREIGN KEY (diversityexperiment_id) REFERENCES diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY feature_gtassay
    ADD CONSTRAINT feature_gtassay_gtassay_id_fkey FOREIGN KEY (gtassay_id) REFERENCES gtassay(gtassay_id) ON DELETE CASCADE;

ALTER TABLE ONLY diversityexperimentprop
    ADD CONSTRAINT diversityexperiment_diversityexperimentprop_fk FOREIGN KEY (diversityexperiment_id) REFERENCES diversityexperiment(diversityexperiment_id);

ALTER TABLE ONLY geolocationprop
    ADD CONSTRAINT geolocation_geolocationprop_fk FOREIGN KEY (geolocation_id) REFERENCES geolocation(geolocation_id);

ALTER TABLE ONLY gtassay
    ADD CONSTRAINT gtassay_image_id_fkey FOREIGN KEY (image_id) REFERENCES image(image_id) ON DELETE RESTRICT;

ALTER TABLE ONLY gtassay_reagent
    ADD CONSTRAINT gtassay_reagent_gtassay_id_fkey FOREIGN KEY (gtassay_id) REFERENCES gtassay(gtassay_id) ON DELETE CASCADE;

ALTER TABLE ONLY gtassay_reagent
    ADD CONSTRAINT gtassay_reagent_reagent_id_fkey FOREIGN KEY (reagent_id) REFERENCES reagent(reagent_id) ON DELETE CASCADE;

ALTER TABLE ONLY gtassayprop
    ADD CONSTRAINT gtassayprop_gtassay_id_fkey FOREIGN KEY (gtassay_id) REFERENCES gtassay(gtassay_id) ON DELETE CASCADE;

ALTER TABLE ONLY gtexperiment
    ADD CONSTRAINT gtexperiment_gtassay_id_fkey FOREIGN KEY (gtassay_id) REFERENCES gtassay(gtassay_id) ON DELETE RESTRICT;

ALTER TABLE ONLY ptexperiment
    ADD CONSTRAINT new_table_ptexperiment_fk FOREIGN KEY (ptassay_reagent_id) REFERENCES ptassay_reagent(ptassay_reagent_id);

ALTER TABLE ONLY ptassayprop
    ADD CONSTRAINT ptassayprop_ptassay_id_fkey FOREIGN KEY (ptassay_id) REFERENCES ptassay(ptassay_id) ON DELETE CASCADE;

ALTER TABLE ONLY ptexperiment
    ADD CONSTRAINT ptexperiment_ptassay_id_fkey FOREIGN KEY (ptassay_id) REFERENCES ptassay(ptassay_id) ON DELETE RESTRICT;

ALTER TABLE ONLY ptassay_reagent
    ADD CONSTRAINT reagent_new_table_fk FOREIGN KEY (reagent_id) REFERENCES reagent(reagent_id);

ALTER TABLE ONLY reagent_relationship
    ADD CONSTRAINT reagent_relationship_object_reagent_id_fkey FOREIGN KEY (object_reagent_id) REFERENCES reagent(reagent_id) ON DELETE CASCADE;

ALTER TABLE ONLY reagent_relationship
    ADD CONSTRAINT reagent_relationship_subject_reagent_id_fkey FOREIGN KEY (subject_reagent_id) REFERENCES reagent(reagent_id) ON DELETE CASCADE;

ALTER TABLE ONLY stock_image
    ADD CONSTRAINT stock_image_image_id_fkey FOREIGN KEY (image_id) REFERENCES image(image_id) ON DELETE RESTRICT;

ALTER TABLE ONLY diversityexperiment
    ADD CONSTRAINT stocksample_diversityexperiment_fk FOREIGN KEY (stocksample_id) REFERENCES stocksample(stocksample_id);

ALTER TABLE ONLY stocksampleprop
    ADD CONSTRAINT stocksampleprop_stocksample_id_fkey FOREIGN KEY (stocksample_id) REFERENCES stocksample(stocksample_id) ON DELETE CASCADE;

