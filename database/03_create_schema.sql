-- ==============================================
-- Sample Data for Portfolio Database (MySQL)
-- ==============================================

-- Insert skill categories
INSERT INTO skill_categories (id, name, display_order) VALUES
(UUID(), 'Langages de Programmation', 1),
(UUID(), 'Frameworks & Libraries', 2),
(UUID(), 'Base de Données', 3),
(UUID(), 'Outils & Technologies', 4),
(UUID(), 'Soft Skills', 5);

-- Insert sample skills
INSERT INTO skills (id, name, level, category_id, icon_url, description, years_experience, is_featured) VALUES
-- Langages
(UUID(), 'Java', 5, (SELECT id FROM skill_categories WHERE name = 'Langages de Programmation'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg', 'Développement backend avec Spring Boot', 3, true),
(UUID(), 'JavaScript', 4, (SELECT id FROM skill_categories WHERE name = 'Langages de Programmation'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg', 'Frontend et backend avec Node.js', 2, true),
(UUID(), 'TypeScript', 4, (SELECT id FROM skill_categories WHERE name = 'Langages de Programmation'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/typescript/typescript-original.svg', 'Développement frontend type-safe', 2, true),
(UUID(), 'Python', 3, (SELECT id FROM skill_categories WHERE name = 'Langages de Programmation'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg', 'Scripts et data analysis', 1, false),

-- Frameworks
(UUID(), 'Spring Boot', 5, (SELECT id FROM skill_categories WHERE name = 'Frameworks & Libraries'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/spring/spring-original.svg', 'Framework principal pour APIs REST', 3, true),
(UUID(), 'React', 4, (SELECT id FROM skill_categories WHERE name = 'Frameworks & Libraries'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/react/react-original.svg', 'Bibliothèque frontend moderne', 2, true),
(UUID(), 'Spring Security', 4, (SELECT id FROM skill_categories WHERE name = 'Frameworks & Libraries'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/spring/spring-original.svg', 'Sécurisation des APIs', 2, false),

-- Bases de données
(UUID(), 'MySQL', 4, (SELECT id FROM skill_categories WHERE name = 'Base de Données'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original.svg', 'Base de données relationnelle', 2, true),
(UUID(), 'MongoDB', 3, (SELECT id FROM skill_categories WHERE name = 'Base de Données'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mongodb/mongodb-original.svg', 'Base de données NoSQL', 1, false),

-- Outils
(UUID(), 'Git', 4, (SELECT id FROM skill_categories WHERE name = 'Outils & Technologies'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg', 'Contrôle de version', 3, false),
(UUID(), 'Docker', 3, (SELECT id FROM skill_categories WHERE name = 'Outils & Technologies'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original.svg', 'Containerisation', 1, false),
(UUID(), 'VS Code', 5, (SELECT id FROM skill_categories WHERE name = 'Outils & Technologies'), 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg', 'Environnement de développement', 3, false);

-- Insert project categories
INSERT INTO project_categories (id, name, color) VALUES
(UUID(), 'Web Application', '#3B82F6'),
(UUID(), 'API Development', '#10B981'),
(UUID(), 'Mobile App', '#8B5CF6'),
(UUID(), 'Data Science', '#F59E0B'),
(UUID(), 'Other', '#6B7280');

-- Insert sample projects
INSERT INTO projects (id, title, short_description, long_description, technologies, category_id, github_url, demo_url, featured_image, status, is_featured) VALUES
(
    UUID(),
    'E-Commerce Platform',
    'Application e-commerce complète avec gestion des produits, commandes et paiements',
    'Développement d''une plateforme e-commerce moderne avec Spring Boot pour le backend, React pour le frontend et MySQL pour la persistance. Intégration de Stripe pour les paiements et système d''authentification JWT.',
    '["Java", "Spring Boot", "React", "MySQL", "Docker", "Stripe API"]',
    (SELECT id FROM project_categories WHERE name = 'Web Application'),
    'https://github.com/username/ecommerce-platform',
    'https://ecommerce-demo.vercel.app',
    'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=500',
    'COMPLETED',
    true
),
(
    UUID(),
    'Task Management API',
    'API REST pour la gestion de tâches avec authentification et autorisation',
    'API robuste développée avec Spring Boot, incluant authentification JWT, autorisation basée sur les rôles, et documentation Swagger. Tests unitaires et d''intégration avec JUnit.',
    '["Java", "Spring Boot", "Spring Security", "JUnit", "Swagger", "Maven"]',
    (SELECT id FROM project_categories WHERE name = 'API Development'),
    'https://github.com/username/task-api',
    NULL,
    'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=500',
    'COMPLETED',
    true
),
(
    UUID(),
    'Weather Dashboard',
    'Dashboard météorologique avec données en temps réel',
    'Application React consommant des APIs météorologiques externes avec graphiques interactifs et géolocalisation.',
    '["React", "TypeScript", "Chart.js", "Tailwind CSS", "OpenWeather API"]',
    (SELECT id FROM project_categories WHERE name = 'Web Application'),
    'https://github.com/username/weather-dashboard',
    'https://weather-dashboard-demo.netlify.app',
    'https://images.unsplash.com/photo-1592210454359-9043f067919b?w=500',
    'COMPLETED',
    false
);

-- Insert sample experiences
INSERT INTO experiences (id, company, position, location, start_date, end_date, description, achievements, technologies, is_current) VALUES
(
    UUID(),
    'TechCorp Solutions',
    'Développeur Full-Stack Junior',
    'Paris, France',
    '2023-01-15',
    NULL,
    'Développement d''applications web modernes en équipe agile. Participation à tous les aspects du cycle de développement.',
    '["Développement de 3 applications web utilisées par 1000+ utilisateurs", "Amélioration des performances de 40% sur l''API principale", "Mise en place de tests automatisés augmentant la couverture à 85%"]',
    '["Java", "Spring Boot", "React", "MySQL", "Docker", "Git"]',
    true
),
(
    UUID(),
    'Digital Agency Pro',
    'Stagiaire Développeur',
    'Lyon, France',
    '2022-06-01',
    '2022-08-31',
    'Stage de développement web avec focus sur le frontend React et l''intégration d''APIs.',
    '["Création de 5 composants React réutilisables", "Intégration de 3 APIs externes", "Collaboration sur un projet client de 2 mois"]',
    '["JavaScript", "React", "CSS", "HTML", "REST APIs"]',
    false
);

-- Insert sample education
INSERT INTO educations (id, institution, degree, field_of_study, start_date, end_date, location, description) VALUES
(
    UUID(),
    'Université de Technologie',
    'Master',
    'Informatique et Systèmes d''Information',
    '2021-09-01',
    '2023-06-30',
    'Paris, France',
    'Spécialisation en développement web et architecture logicielle. Projets en équipe et stage en entreprise.'
),
(
    UUID(),
    'IUT Informatique',
    'DUT',
    'Informatique',
    '2019-09-01',
    '2021-06-30',
    'Lyon, France',
    'Formation technique complète en programmation, bases de données et réseaux.'
);

-- Insert site settings
INSERT INTO site_settings (id, setting_key, setting_value, description) VALUES
(UUID(), 'site_title', 'Mon Portfolio - Développeur Full-Stack', 'Titre principal du site'),
(UUID(), 'site_description', 'Portfolio de développeur Full-Stack spécialisé en Java/Spring Boot et React', 'Description pour le SEO'),
(UUID(), 'contact_email', 'contact@monportfolio.com', 'Email de contact principal'),
(UUID(), 'github_url', 'https://github.com/username', 'Profil GitHub'),
(UUID(), 'linkedin_url', 'https://linkedin.com/in/username', 'Profil LinkedIn'),
(UUID(), 'hero_title', 'Développeur Full-Stack', 'Titre de la section hero'),
(UUID(), 'hero_subtitle', 'Je crée des applications web modernes avec Java et React', 'Sous-titre de la section hero'),
(UUID(), 'about_text', 'Passionné par le développement web, je combine expertise technique et créativité pour créer des solutions innovantes.', 'Texte de présentation'),
(UUID(), 'cv_url', '/assets/cv.pdf', 'Lien vers le CV téléchargeable');

-- Create admin user (password: admin123 - À CHANGER EN PRODUCTION!)
-- Utilisation de SHA2 pour le hachage (MySQL natif)
INSERT INTO users (id, username, email, password_hash, role) VALUES
(UUID(), 'admin', 'admin@portfolio.com', SHA2('admin123', 256), 'ADMIN');
