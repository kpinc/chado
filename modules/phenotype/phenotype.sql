-- $Id: phenotype.sql,v 1.6 2007-04-27 16:09:46 emmert Exp $
-- ==========================================
-- Chado phenotype module
--

-- =================================================================
-- Dependencies:
--
-- :import cvterm from cv
-- :import feature from sequence
-- =================================================================

-- ================================================
-- TABLE: phenotype
-- ================================================

CREATE TABLE phenotype (
    phenotype_id SERIAL NOT NULL,
    primary key (phenotype_id),
    uniquename TEXT,  
    observable_id INT,
    FOREIGN KEY (observable_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE,
    attr_id INT,
    FOREIGN KEY (attr_id) REFERENCES cvterm (cvterm_id) ON DELETE SET NULL,
    value TEXT,
    units_id INT,
    FOREIGN KEY (units_id) REFERENCES cvterm (cvterm_id) ON DELETE SET NULL,
    cvalue_id INT,
    FOREIGN KEY (cvalue_id) REFERENCES cvterm (cvterm_id) ON DELETE SET NULL,
    assay_id INT,
    FOREIGN KEY (assay_id) REFERENCES cvterm (cvterm_id) ON DELETE SET NULL
);
CREATE INDEX phenotype_idx1 ON phenotype (cvalue_id);
CREATE INDEX phenotype_idx2 ON phenotype (observable_id);
CREATE INDEX phenotype_idx3 ON phenotype (attr_id);

COMMENT ON TABLE phenotype IS 'A phenotypic statement, or a single
atomic phenotypic observation, is a controlled sentence describing
observable effects of non-wild type function. E.g. Obs=eye, attribute=color, cvalue=red.';
COMMENT ON COLUMN phenotype.observable_id IS 'The entity: e.g. anatomy_part, biological_process.';
COMMENT ON COLUMN phenotype.attr_id IS 'Phenotypic attribute (quality, property, attribute, character) - drawn from PATO.';
COMMENT ON COLUMN phenotype.value IS 'Value of attribute - unconstrained free text. Used only if cvalue_id is not appropriate.';
COMMENT ON COLUMN phenotype.units_id IS 'Phenotype value units of measurement.';
COMMENT ON COLUMN phenotype.cvalue_id IS 'Phenotype attribute value (state).';
COMMENT ON COLUMN phenotype.assay_id IS 'Evidence type.';

-- ================================================                             
-- TABLE: phenotypeprop                                                         
-- ================================================                             
                                                                                
CREATE TABLE phenotypeprop (                                                    
    phenotypeprop_id serial NOT NULL,                                       
    PRIMARY KEY (phenotypeprop_id),                                         
    phenotype_id integer NOT NULL,                                          
    FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE,                                                                      
    type_id integer NOT NULL,                                               
    FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE,  
    value text,                                                             
    cvalue_id INT,
    FOREIGN KEY (cvalue_id) REFERENCES cvterm (cvterm_id) ON DELETE SET NULL,
    rank integer not null default 0,                                        
    CONSTRAINT phenotypeprop_c1 UNIQUE (phenotype_id, type_id, rank)        
);                                                                              
COMMENT ON TABLE phenotypeprop IS 'A phenotype property should either have a value defined in phenotypeprop.value or in phenotypeprop.cvalue_id but not in both fields.';
COMMENT ON COLUMN phenotypeprop.value IS 'Property value is free text.';
COMMENT ON COLUMN phenotypeprop.cvalue_id IS 'Property value is a cvterm.';

-- ================================================
-- TABLE: phenotype_cvterm
-- ================================================

CREATE TABLE phenotype_cvterm (
    phenotype_cvterm_id SERIAL NOT NULL,
    primary key (phenotype_cvterm_id),
    phenotype_id INT NOT NULL,
    FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE,
    cvterm_id INT NOT NULL,
    FOREIGN KEY (cvterm_id) REFERENCES cvterm (cvterm_id) ON DELETE CASCADE,
    rank int not null default 0,
    CONSTRAINT phenotype_cvterm_c1 UNIQUE (phenotype_id, cvterm_id, rank)
);
CREATE INDEX phenotype_cvterm_idx1 ON phenotype_cvterm (phenotype_id);
CREATE INDEX phenotype_cvterm_idx2 ON phenotype_cvterm (cvterm_id);

COMMENT ON TABLE phenotype_cvterm IS 'Deprecated and superceded by phenotypeprop.';

-- ================================================
-- TABLE: feature_phenotype
-- ================================================

CREATE TABLE feature_phenotype (
    feature_phenotype_id SERIAL NOT NULL,
    primary key (feature_phenotype_id),
    feature_id INT NOT NULL,
    FOREIGN KEY (feature_id) REFERENCES feature (feature_id) ON DELETE CASCADE,
    phenotype_id INT NOT NULL,
    FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE,
    CONSTRAINT feature_phenotype_c1 UNIQUE (feature_id,phenotype_id)       
);
CREATE INDEX feature_phenotype_idx1 ON feature_phenotype (feature_id);
CREATE INDEX feature_phenotype_idx2 ON feature_phenotype (phenotype_id);

COMMENT ON TABLE feature_phenotype IS NULL;
