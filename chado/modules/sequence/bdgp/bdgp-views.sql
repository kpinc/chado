-- bdgp-views.sql
--
-- Chris Mungall, BDGP
--
-- these are a set of handy views used over chado within BDGP
-- typically they provide a flatter/denormalised view over chado
-- which is useful for simplifying queries

-- ================================================
-- featurepropd = featureprop * cvterm
-- ================================================
-- Adds property type name to featureprop

CREATE OR REPLACE VIEW featurepropd AS
 SELECT featureprop.*, 
        cvterm.name AS type
 FROM 
   featureprop
    INNER JOIN cvterm ON (featureprop.type_id=cvterm.cvterm_id);

-- ================================================
-- dbxrefd = dbxref * db
-- ================================================
-- Adds dbname to dbxref
CREATE OR REPLACE VIEW dbxrefd AS
 SELECT dbxref.*,
        db.name AS dbname
 FROM
  dbxref INNER JOIN db USING (db_id);

-- ================================================
-- xcvterm = cvterm * dbxref
-- ================================================
-- Adds dbxref to cvterm
CREATE OR REPLACE VIEW xcvterm AS
 SELECT cvterm.*,
        dbxrefd.dbname,
        dbxrefd.accession,
        dbxrefd.version
 FROM
  cvterm INNER JOIN dbxrefd USING (dbxref_id);

-- ================================================
-- tfeature = feature * cvterm
-- ================================================
-- Adds feature type name to feature
CREATE OR REPLACE VIEW tfeature AS
 SELECT feature.*,
        cvterm.name AS type
 FROM
  feature INNER JOIN cvterm ON (feature.type_id=cvterm.cvterm_id);

-- ================================================
-- xfeature = feature * dbxref
-- ================================================
-- Adds dbxref to feature
CREATE OR REPLACE VIEW xfeature AS
 SELECT feature.*,
        dbxrefd.dbname,
        dbxrefd.accession,
        dbxrefd.version
 FROM
  feature INNER JOIN dbxrefd USING (dbxref_id);

-- ================================================
-- txfeature = xfeature * cvterm
-- ================================================
-- cross product of tfeature and xfeature
CREATE OR REPLACE VIEW txfeature AS
 SELECT xfeature.*,
        cvterm.name AS type
 FROM
  xfeature INNER JOIN cvterm ON (xfeature.type_id=cvterm.cvterm_id);

-- ================================================
-- featurelocf = featureloc * (src)feature
-- ================================================
-- Adds srcfeature name to featureloc
CREATE OR REPLACE VIEW featurelocf AS
 SELECT featureloc.*,
        feature.name AS srcname,
        feature.uniquename AS srcuniquename
 FROM
  featureloc INNER JOIN feature ON (featureloc.srcfeature_id=feature.feature_id);

-- ================================================
-- ffeature = feature * featureloc (rank=0) (locgroup 0)
-- ================================================
-- adds main location to feature
CREATE OR REPLACE VIEW ffeature AS
 SELECT feature.*,
        featureloc.*
 FROM
  feature INNER JOIN featureloc USING (feature_id)
 WHERE rank=0 AND locgroup=0;

-- ================================================
-- featurepair = feature * featureloc^2 (locgroup 0)
-- ================================================
-- features with two locations
CREATE OR REPLACE VIEW featurepair AS
 SELECT feature.*,

        fl1.srcfeature_id,
        fl1.fmin,
        fl1.fmax,
        fl1.strand,
        fl1.phase,

        fl2.srcfeature_id AS tsrcfeature_id,
        fl2.fmin AS tfmin,
        fl2.fmax AS tfmax,
        fl2.strand AS tstrand,
        fl2.phase AS tphase
 FROM
  feature 
  INNER JOIN featureloc AS fl1 USING (feature_id)
  INNER JOIN featureloc AS fl2 USING (feature_id)
 WHERE fl1.rank=0 AND fl2.rank=0 AND fl1.locgroup=0 AND fl2.locgroup=0;