-- --------------------------------------------------
-- TABLES DE REFERENCIA / AUXILIARES
-- --------------------------------------------------

CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE paradigm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE company (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE license (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE common_use (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

-- --------------------------------------------------
-- TABLA PRINCIPAL: technologies
-- --------------------------------------------------

CREATE TABLE technologies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    release_year INT NULL,

    category_id INT NULL,
    type_id INT NULL,
    paradigm_id INT NULL,
    company_id INT NULL,
    license_id INT NULL,

    CONSTRAINT fk_tech_category
        FOREIGN KEY (category_id)
        REFERENCES category(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_tech_type
        FOREIGN KEY (type_id)
        REFERENCES type(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_tech_paradigm
        FOREIGN KEY (paradigm_id)
        REFERENCES paradigm(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_tech_company
        FOREIGN KEY (company_id)
        REFERENCES company(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_tech_license
        FOREIGN KEY (license_id)
        REFERENCES license(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- --------------------------------------------------
-- TABLA DE USOS (RELACIÓN N:M)
-- --------------------------------------------------

CREATE TABLE technology_uses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    technology_id INT NOT NULL,
    use_id INT NOT NULL,

    CONSTRAINT fk_use_technology
        FOREIGN KEY (technology_id)
        REFERENCES technologies(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_use_common
        FOREIGN KEY (use_id)
        REFERENCES common_use(id)
        ON DELETE CASCADE
);

CREATE TABLE influenced_by (
    technology_id INT,
    influenced_by_id INT,
        FOREIGN KEY (technology_id) 
        REFERENCES technologies(id),
        FOREIGN KEY (influenced_by_id) 
        REFERENCES technologies(id)
        ON DELETE CASCADE
);

-- =====================
-- Categories
-- =====================
INSERT INTO category (name) VALUES
  ('programming_language'),
  ('framework'),
  ('database'),
  ('query_language'),
  ('orchestration_platform'),
  ('library');

-- =====================
-- Types
-- =====================
INSERT INTO type (name) VALUES
  ('backend'),
  ('frontend'),
  ('relational'),
  ('nosql'),
  ('fullstack'),
  ('api'),
  ('infrastructure'),
  ('compute');

-- =====================
-- Paradigms
-- =====================
INSERT INTO paradigm (name) VALUES
  ('object_oriented'),
  ('multiparadigm'),
  ('functional'),
  ('mvc'),
  ('declarative'),
  ('component_based'),
  ('dataflow'),
  ('orchestration'),
  ('relational'),
  ('document_oriented');

-- =====================
-- Companies
-- =====================
INSERT INTO company (name) VALUES
  ('Oracle Corporation'),
  ('Microsoft'),
  ('Rails Core Team'),
  ('PostgreSQL Global Development Group'),
  ('Google'),
  ('VMware'),
  ('Google Brain'),
  ('Cloud Native Computing Foundation'),
  ('Meta (Facebook)'),
  ('Elastic NV');

-- =====================
-- Licenses
-- =====================
INSERT INTO license (name) VALUES
  ('GPL'),
  ('MIT'),
  ('PostgreSQL License'),
  ('Apache 2.0'),
  ('BSD');

-- =====================
-- Common Uses
-- =====================
INSERT INTO common_use (name) VALUES
  ('web development'),
  ('enterprise applications'),
  ('desktop applications'),
  ('game development'),
  ('data storage'),
  ('analytics'),
  ('frontend UI'),
  ('AI/ML'),
  ('container orchestration'),
  ('API design'),
  ('search');

-- 1. Java
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'Java', 1995,
  (SELECT id FROM category WHERE name='programming_language'),
  (SELECT id FROM type WHERE name='backend'),
  (SELECT id FROM paradigm WHERE name='multiparadigm'),
  (SELECT id FROM company WHERE name='Oracle Corporation'),
  (SELECT id FROM license WHERE name='GPL')
);

-- 2. C#
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'C#', 2000,
  (SELECT id FROM category WHERE name='programming_language'),
  (SELECT id FROM type WHERE name='backend'),
  (SELECT id FROM paradigm WHERE name='object_oriented'),
  (SELECT id FROM company WHERE name='Microsoft'),
  (SELECT id FROM license WHERE name='MIT')
);

-- 3. Ruby on Rails
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'Ruby on Rails', 2004,
  (SELECT id FROM category WHERE name='framework'),
  (SELECT id FROM type WHERE name='backend'),
  (SELECT id FROM paradigm WHERE name='mvc'),
  (SELECT id FROM company WHERE name='Rails Core Team'),
  (SELECT id FROM license WHERE name='MIT')
);

-- 4. PostgreSQL
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'PostgreSQL', 1996,
  (SELECT id FROM category WHERE name='database'),
  (SELECT id FROM type WHERE name='relational'),
  (SELECT id FROM paradigm WHERE name='relational'),
  (SELECT id FROM company WHERE name='PostgreSQL Global Development Group'),
  (SELECT id FROM license WHERE name='PostgreSQL License')
);

-- 5. Angular
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'Angular', 2016,
  (SELECT id FROM category WHERE name='framework'),
  (SELECT id FROM type WHERE name='frontend'),
  (SELECT id FROM paradigm WHERE name='component_based'),
  (SELECT id FROM company WHERE name='Google'),
  (SELECT id FROM license WHERE name='MIT')
);

-- 6. Spring
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'Spring', 2002,
  (SELECT id FROM category WHERE name='framework'),
  (SELECT id FROM type WHERE name='backend'),
  (SELECT id FROM paradigm WHERE name='declarative'),
  (SELECT id FROM company WHERE name='VMware'),
  (SELECT id FROM license WHERE name='Apache 2.0')
);

-- 7. TensorFlow
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'TensorFlow', 2015,
  (SELECT id FROM category WHERE name='library'),
  (SELECT id FROM type WHERE name='compute'),
  (SELECT id FROM paradigm WHERE name='dataflow'),
  (SELECT id FROM company WHERE name='Google Brain'),
  (SELECT id FROM license WHERE name='Apache 2.0')
);

-- 8. Kubernetes
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'Kubernetes', 2014,
  (SELECT id FROM category WHERE name='orchestration_platform'),
  (SELECT id FROM type WHERE name='infrastructure'),
  (SELECT id FROM paradigm WHERE name='orchestration'),
  (SELECT id FROM company WHERE name='Cloud Native Computing Foundation'),
  (SELECT id FROM license WHERE name='Apache 2.0')
);

-- 9. GraphQL
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'GraphQL', 2015,
  (SELECT id FROM category WHERE name='query_language'),
  (SELECT id FROM type WHERE name='api'),
  (SELECT id FROM paradigm WHERE name='declarative'),
  (SELECT id FROM company WHERE name='Meta (Facebook)'),
  (SELECT id FROM license WHERE name='MIT')
);

-- 10. Elasticsearch
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES (
  'Elasticsearch', 2010,
  (SELECT id FROM category WHERE name='database'),
  (SELECT id FROM type WHERE name='nosql'),
  (SELECT id FROM paradigm WHERE name='document_oriented'),
  (SELECT id FROM company WHERE name='Elastic NV'),
  (SELECT id FROM license WHERE name='Apache 2.0')
);

-- Java
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='Java'),
  (SELECT id FROM technologies WHERE name='C++')
);

-- C#
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES
  ((SELECT id FROM technologies WHERE name='C#'), (SELECT id FROM technologies WHERE name='Java')),
  ((SELECT id FROM technologies WHERE name='C#'), (SELECT id FROM technologies WHERE name='C++'));

-- Ruby on Rails
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Ruby on Rails'), (SELECT id FROM technologies WHERE name='Ruby')),
  ((SELECT id FROM technologies WHERE name='Ruby on Rails'), (SELECT id FROM technologies WHERE name='Smalltalk'));

-- PostgreSQL
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='PostgreSQL'),
  (SELECT id FROM technologies WHERE name='Ingres')
);

-- Angular
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Angular'), (SELECT id FROM technologies WHERE name='AngularJS'));

-- Spring
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='Spring'),
  (SELECT id FROM technologies WHERE name='Java')
);

-- TensorFlow
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='TensorFlow'),
  (SELECT id FROM technologies WHERE name='Theano')
);

-- Kubernetes
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='Kubernetes'),
  (SELECT id FROM technologies WHERE name='Borg')
);

-- GraphQL
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='GraphQL'),
  (SELECT id FROM technologies WHERE name='REST')
);

-- Elasticsearch
INSERT INTO influenced_by (technology_id, influenced_by_id)
VALUES (
  (SELECT id FROM technologies WHERE name='Elasticsearch'),
  (SELECT id FROM technologies WHERE name='Apache Lucene')
);

-- Java
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Java'), (SELECT id FROM common_use WHERE name='web development')),
  ((SELECT id FROM technologies WHERE name='Java'), (SELECT id FROM common_use WHERE name='enterprise applications'));

-- C#
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='C#'), (SELECT id FROM common_use WHERE name='web development')),
  ((SELECT id FROM technologies WHERE name='C#'), (SELECT id FROM common_use WHERE name='desktop applications')),
  ((SELECT id FROM technologies WHERE name='C#'), (SELECT id FROM common_use WHERE name='game development'));

-- Ruby on Rails
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Ruby on Rails'), (SELECT id FROM common_use WHERE name='web development'));

-- PostgreSQL
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='PostgreSQL'), (SELECT id FROM common_use WHERE name='data storage')),
  ((SELECT id FROM technologies WHERE name='PostgreSQL'), (SELECT id FROM common_use WHERE name='analytics')),
  ((SELECT id FROM technologies WHERE name='PostgreSQL'), (SELECT id FROM common_use WHERE name='web development'));

-- Angular
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Angular'), (SELECT id FROM common_use WHERE name='frontend UI')),
  ((SELECT id FROM technologies WHERE name='Angular'), (SELECT id FROM common_use WHERE name='web development'));

-- Spring
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Spring'), (SELECT id FROM common_use WHERE name='web development')),
  ((SELECT id FROM technologies WHERE name='Spring'), (SELECT id FROM common_use WHERE name='enterprise applications'));

-- TensorFlow
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='TensorFlow'), (SELECT id FROM common_use WHERE name='AI/ML')),
  ((SELECT id FROM technologies WHERE name='TensorFlow'), (SELECT id FROM common_use WHERE name='analytics'));

-- Kubernetes
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Kubernetes'), (SELECT id FROM common_use WHERE name='container orchestration')),
  ((SELECT id FROM technologies WHERE name='Kubernetes'), (SELECT id FROM common_use WHERE name='web development'));

-- GraphQL
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='GraphQL'), (SELECT id FROM common_use WHERE name='API design')),
  ((SELECT id FROM technologies WHERE name='GraphQL'), (SELECT id FROM common_use WHERE name='web development'));

-- Elasticsearch
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  ((SELECT id FROM technologies WHERE name='Elasticsearch'), (SELECT id FROM common_use WHERE name='search')),
  ((SELECT id FROM technologies WHERE name='Elasticsearch'), (SELECT id FROM common_use WHERE name='analytics')),
  ((SELECT id FROM technologies WHERE name='Elasticsearch'), (SELECT id FROM common_use WHERE name='data storage'));
