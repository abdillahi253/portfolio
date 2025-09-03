-- ==============================================
-- Useful Views for Portfolio Database (MySQL)
-- ==============================================

-- Vue pour afficher les projets avec leur catégorie
CREATE VIEW projects_with_category AS
SELECT 
    p.id,
    p.title,
    p.short_description,
    p.long_description,
    p.technologies,
    pc.name as category_name,
    pc.color as category_color,
    p.github_url,
    p.demo_url,
    p.image_urls,
    p.featured_image,
    p.start_date,
    p.end_date,
    p.status,
    p.is_featured,
    p.display_order,
    p.created_at,
    p.updated_at
FROM projects p
LEFT JOIN project_categories pc ON p.category_id = pc.id
ORDER BY p.display_order ASC, p.created_at DESC;

-- Vue pour afficher les compétences avec leur catégorie
CREATE VIEW skills_with_category AS
SELECT 
    s.id,
    s.name,
    s.level,
    sc.name as category_name,
    s.icon_url,
    s.description,
    s.years_experience,
    s.display_order,
    s.is_featured,
    s.created_at,
    s.updated_at
FROM skills s
LEFT JOIN skill_categories sc ON s.category_id = sc.id
ORDER BY sc.display_order ASC, s.display_order ASC, s.level DESC;
