-- ==============================================
-- Portfolio Database Schema Creation (MySQL)
-- ==============================================

-- Table: skill_categories
CREATE TABLE skill_categories (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(50) UNIQUE NOT NULL,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: skills
CREATE TABLE skills (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    level INT CHECK (level >= 1 AND level <= 5), -- 1-5 étoiles
    category_id VARCHAR(36),
    icon_url VARCHAR(255),
    description TEXT,
    years_experience INT DEFAULT 0,
    display_order INT DEFAULT 0,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES skill_categories(id) ON DELETE CASCADE
);

-- Table: project_categories
CREATE TABLE project_categories (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(50) UNIQUE NOT NULL,
    color VARCHAR(7), -- Couleur hex pour l'affichage
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: projects
CREATE TABLE projects (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    title VARCHAR(200) NOT NULL,
    short_description VARCHAR(500),
    long_description TEXT,
    technologies JSON, -- Array des technologies utilisées
    category_id VARCHAR(36),
    github_url VARCHAR(255),
    demo_url VARCHAR(255),
    image_urls JSON, -- Array des URLs d'images
    featured_image VARCHAR(255),
    start_date DATE,
    end_date DATE,
    status ENUM('IN_PROGRESS', 'COMPLETED', 'ARCHIVED') DEFAULT 'COMPLETED',
    is_featured BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES project_categories(id)
);

-- Table: experiences
CREATE TABLE experiences (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    company VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE, -- NULL si poste actuel
    description TEXT,
    achievements JSON, -- Array des réalisations principales
    technologies JSON, -- Technologies utilisées
    is_current BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table: educations
CREATE TABLE educations (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    institution VARCHAR(100) NOT NULL,
    degree VARCHAR(100) NOT NULL,
    field_of_study VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    description TEXT,
    location VARCHAR(100),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: contacts
CREATE TABLE contacts (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    phone VARCHAR(20),
    company VARCHAR(100),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
