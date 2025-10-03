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

-- Categorías
INSERT INTO category (name) VALUES
  ('programming_language'),
  ('database'),
  ('framework');

-- Tipos
INSERT INTO type (name) VALUES
  ('backend'),
  ('frontend'),
  ('relational');

-- Paradigmas
INSERT INTO paradigm (name) VALUES
  ('multiparadigm'),
  ('declarative'),
  ('relational');

-- Compañías
INSERT INTO company (name) VALUES
  ('Python Software Foundation'),
  ('Oracle Corporation'),
  ('Vue.js Foundation');

-- Licencias
INSERT INTO license (name) VALUES
  ('PSF License'),
  ('GPL'),
  ('MIT');

-- Usos comunes
INSERT INTO common_use (name) VALUES
  ('web development'),
  ('data science'),
  ('AI/ML'),
  ('data storage'),
  ('frontend UI');

-- Tecnologías
INSERT INTO technologies (name, release_year, category_id, type_id, paradigm_id, company_id, license_id)
VALUES
  ('Python', 1991,
    (SELECT id FROM category WHERE name = 'programming_language'),
    (SELECT id FROM type WHERE name = 'backend'),
    (SELECT id FROM paradigm WHERE name = 'multiparadigm'),
    (SELECT id FROM company WHERE name = 'Python Software Foundation'),
    (SELECT id FROM license WHERE name = 'PSF License')
  ),
  ('MySQL', 1995,
    (SELECT id FROM category WHERE name = 'database'),
    (SELECT id FROM type WHERE name = 'relational'),
    (SELECT id FROM paradigm WHERE name = 'relational'),
    (SELECT id FROM company WHERE name = 'Oracle Corporation'),
    (SELECT id FROM license WHERE name = 'GPL')
  ),
  ('Vue.js', 2014,
    (SELECT id FROM category WHERE name = 'framework'),
    (SELECT id FROM type WHERE name = 'frontend'),
    (SELECT id FROM paradigm WHERE name = 'declarative'),
    (SELECT id FROM company WHERE name = 'Vue.js Foundation'),
    (SELECT id FROM license WHERE name = 'MIT')
  );

-- Relación tecnologías ↔ usos
INSERT INTO technology_uses (technology_id, use_id)
VALUES
  -- Python
  ((SELECT id FROM technologies WHERE name = 'Python'), (SELECT id FROM common_use WHERE name = 'web development')),
  ((SELECT id FROM technologies WHERE name = 'Python'), (SELECT id FROM common_use WHERE name = 'data science')),
  ((SELECT id FROM technologies WHERE name = 'Python'), (SELECT id FROM common_use WHERE name = 'AI/ML')),

  -- MySQL
  ((SELECT id FROM technologies WHERE name = 'MySQL'), (SELECT id FROM common_use WHERE name = 'data storage')),

  -- Vue.js
  ((SELECT id FROM technologies WHERE name = 'Vue.js'), (SELECT id FROM common_use WHERE name = 'frontend UI')),
  ((SELECT id FROM technologies WHERE name = 'Vue.js'), (SELECT id FROM common_use WHERE name = 'web development'));
