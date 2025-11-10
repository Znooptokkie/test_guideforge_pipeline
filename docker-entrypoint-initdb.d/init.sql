-- DROP DATABASE guideforge_db;
CREATE DATABASE IF NOT EXISTS guideforge_db;
USE guideforge_db;

-- //////////////////////////////////
--                                 //
--  All tables without a FK in it  //
--                                 //  
-- //////////////////////////////////

CREATE TABLE category
(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

-- JUNCTION TABLE / JOIN TABLE
CREATE TABLE article_category
(
    article_category_id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    category_id INT NOT NULL
);



CREATE TABLE tag
(
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) NOT NULL UNIQUE
);

-- JUNCTION TABLE / JOIN TABLE
CREATE TABLE article_tag
(
    article_tag_id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    tag_id INT NOT NULL
);



CREATE TABLE tool
(
    tool_id INT AUTO_INCREMENT PRIMARY KEY,
    tool_name VARCHAR(255) NOT NULL UNIQUE
);

-- JUNCTION TABLE / JOIN TABLE
CREATE TABLE article_tool
(
    article_tool_id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    tool_id INT NOT NULL,
    tool_count INT UNSIGNED
);



CREATE TABLE material
(
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    material_name VARCHAR(255) NOT NULL UNIQUE
);

-- JUNCTION TABLE / JOIN TABLE
CREATE TABLE article_material
(
    article_material_id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    material_id INT NOT NULL,
    material_count INT UNSIGNED
);



CREATE TABLE safety_equipment
(
    safety_equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    safety_equipment_name VARCHAR(255) NOT NULL UNIQUE
);

-- JUNCTION TABLE / JOIN TABLE
CREATE TABLE article_safety_equipment
(
    article_safety_equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    safety_equipment_id INT NOT NULL,
    safety_equipment_count INT UNSIGNED
);



-- 4 Rows: Admin, Reader, Writer, Moderator
CREATE TABLE role
(
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL UNIQUE
);



-- //////////////////////////////////
--                                 //
--       All tables with FK        //
--                                 //  
-- //////////////////////////////////

CREATE TABLE user
(
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL UNIQUE,
    user_email VARCHAR(150) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_avatar VARCHAR(255),
    user_created_at DATETIME,
    user_edited_at DATETIME, 
    user_role_id INT
);

CREATE TABLE revision
(
    revision_id INT AUTO_INCREMENT PRIMARY KEY,
    revision_name ENUM("step", "article", "media") NOT NULL, -- Get name of table
    revision_record_id INT NOT NULL, -- PK of chosen table
    revision_data JSON, -- Contains al data from the corresponding table
    revision_created_at DATETIME,
    revision_user_id INT,
    revision_previous_revision_id INT -- Is an FK to itself
);

CREATE TABLE article
(
    article_id INT AUTO_INCREMENT PRIMARY KEY,
    article_is_published BOOLEAN,
    article_published_at DATETIME,
    article_created_at DATETIME,
    article_liked_count INT UNSIGNED,
    article_disliked_count INT UNSIGNED,
    article_view_count INT UNSIGNED,
    article_main_image_id INT,
    article_user_id INT
);

CREATE TABLE media
(
    media_id INT AUTO_INCREMENT PRIMARY KEY,
    media_filename VARCHAR(255) NOT NULL,
    media_url VARCHAR(500) NOT NULL,
    media_mime_type VARCHAR(50),
    media_file_size BIGINT,
    media_upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    media_description TEXT,
    media_is_main_image BOOLEAN,
    media_step_id INT
);

CREATE TABLE step
(
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_index INT,
    step_title VARCHAR(255),
    step_description TEXT,
    step_is_pre_condition BOOLEAN,
    step_article_id INT
);

-- //////////////////////////////////
--                                 //
--          The FK it self         //
--                                 //  
-- //////////////////////////////////

-- USER TABLE
ALTER TABLE user
ADD CONSTRAINT fk_user_role
FOREIGN KEY (user_role_id) REFERENCES role(role_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- REVISION TABLE
ALTER TABLE revision
ADD CONSTRAINT fk_revision_user
FOREIGN KEY (revision_user_id) REFERENCES user(user_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- REVISION TABLE --- Linked list --- FK to itself
ALTER TABLE revision
ADD CONSTRAINT fk_revision_revision
FOREIGN KEY (revision_previous_revision_id) REFERENCES revision(revision_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- ARTICLE TABLE
ALTER TABLE article
ADD CONSTRAINT fk_article_user
FOREIGN KEY (article_user_id) REFERENCES user(user_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- ARTICLE TABLE
ALTER TABLE article
ADD CONSTRAINT fk_article_media
FOREIGN KEY (article_main_image_id) REFERENCES media(media_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- MEDIA TABLE
ALTER TABLE media
ADD CONSTRAINT fk_media_step
FOREIGN KEY (media_step_id) REFERENCES step(step_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- STEP TABLE
ALTER TABLE step
ADD CONSTRAINT fk_step_article
FOREIGN KEY (step_article_id) REFERENCES article(article_id)
ON UPDATE CASCADE
ON DELETE SET NULL;

-- //////////////////////////////////
--                                 //
-- The FK for the JUNCTION TABLES  //
--                                 //  
-- //////////////////////////////////

-- ARTICLE_CATEGORY JUNCTION
ALTER TABLE article_category
ADD CONSTRAINT fk_article_category_article
FOREIGN KEY (article_id) REFERENCES article(article_id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_article_category_category
FOREIGN KEY (category_id) REFERENCES category(category_id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ARTICLE_TAG JUNCTION
ALTER TABLE article_tag
ADD CONSTRAINT fk_article_tag_article
FOREIGN KEY (article_id) REFERENCES article(article_id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_article_tag_tag
FOREIGN KEY (tag_id) REFERENCES tag(tag_id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ARTICLE_TOOL JUNCTION
ALTER TABLE article_tool
ADD CONSTRAINT fk_article_tool_article
FOREIGN KEY (article_id) REFERENCES article(article_id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_article_tool_tool
FOREIGN KEY (tool_id) REFERENCES tool(tool_id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ARTICLE_MATERIAL JUNCTION
ALTER TABLE article_material
ADD CONSTRAINT fk_article_material_article
FOREIGN KEY (article_id) REFERENCES article(article_id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_article_material_material
FOREIGN KEY (material_id) REFERENCES material(material_id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- ARTICLE_SAFETY_EQUIPMENT JUNCTION
ALTER TABLE article_safety_equipment
ADD CONSTRAINT fk_article_safety_equipment_article
FOREIGN KEY (article_id) REFERENCES article(article_id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT fk_article_safety_equipment_safety_equipment
FOREIGN KEY (safety_equipment_id) REFERENCES safety_equipment(safety_equipment_id)
ON UPDATE CASCADE ON DELETE CASCADE;