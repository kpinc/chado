--when schema elements are added, including new tables or changes to table
--columns, or when initialize.sql is changed, the sql to make those changes
--happen should go here.

--gmod version 1.01

--updates to phenotype module  resulting from GMOD hackathon '10
--removal of unique constraint from 'uniquename' column (yes, really)
--addition of units_id col
--creation of new phenotypeprop table
--optional migration path from phenotype_cvterm to phenotypeprop

ALTER TABLE phenotype ALTER uniquename DROP NOT NULL;
ALTER TABLE phenotype DROP CONSTRAINT phenotype_c1;
ALTER TABLE phenotype ADD units_id INT;
ALTER TABLE phenotype ADD FOREIGN KEY (units_id) REFERENCES cvterm (cvterm_id) ON DELETE NO ACTION;
COMMENT ON COLUMN phenotype.units_id IS 'Phenotype value units of measurement.';

CREATE TABLE phenotypeprop (                                                    
     phenotypeprop_id serial NOT NULL,                                       
     PRIMARY KEY (phenotypeprop_id),                                         
     phenotype_id integer NOT NULL,                                          
     FOREIGN KEY (phenotype_id) REFERENCES phenotype (phenotype_id) ON DELETE CASCADE,
     type_id integer NOT NULL,                                               
     FOREIGN KEY (type_id) REFERENCES cvterm (cvterm_id) ON DELETE NO ACTION,  
     value text,                                                             
     cvalue_id INT,
     FOREIGN KEY (cvalue_id) REFERENCES cvterm (cvterm_id) ON DELETE NO ACTION,
     rank integer not null default 0,                                        
     CONSTRAINT phenotypeprop_c1 UNIQUE (phenotype_id, type_id, rank)        
 );

COMMENT ON TABLE phenotypeprop IS 'A phenotype property should either have a value defined in phenotypeprop.value or in phenotypeprop.cvalue_id but not in both fields.';
COMMENT ON COLUMN phenotypeprop.value IS 'Property value is free text.';
COMMENT ON COLUMN phenotypeprop.cvalue_id IS 'Property value is a cvterm.';

COMMENT ON TABLE phenotype_cvterm IS 'Deprecated and superceded by phenotypeprop.';

-- if type_id is known, set below 
-- INSERT INTO phenotypeprop (phenotypeprop_id, phenotype_id, type_id, cvalue_id, rank) SELECT (phenotype_cvterm_id, phenotype_id, -1, cvterm_id, rank) FROM phenotype_cvterm