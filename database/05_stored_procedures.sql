-- ==============================================
-- Stored Procedures for Portfolio Management (MySQL)
-- ==============================================

DELIMITER $$

-- Procédure pour obtenir les projets avec pagination
CREATE PROCEDURE GetProjectsPaginated(
    IN page_size INT DEFAULT 10,
    IN page_number INT DEFAULT 1,
    IN category_filter VARCHAR(36) DEFAULT NULL,
    IN featured_only BOOLEAN DEFAULT FALSE
)
BEGIN
    DECLARE offset_val INT DEFAULT 0;
    SET offset_val = (page_number - 1) * page_size;
    
    SELECT 
        p.id,
        p.title,
        p.short_description,
        p.technologies,
        pc.name as category_name,
        pc.color as category_color,
        p.github_url,
        p.demo_url,
        p.featured_image,
        p.is_featured,
        p.created_at,
        (SELECT COUNT(*) FROM projects p2 
         LEFT JOIN project_categories pc2 ON p2.category_id = pc2.id
         WHERE p2.status = 'COMPLETED'
         AND (category_filter IS NULL OR p2.category_id = category_filter)
         AND (featured_only = FALSE OR p2.is_featured = TRUE)
        ) as total_count
    FROM projects p
    LEFT JOIN project_categories pc ON p.category_id = pc.id
    WHERE p.status = 'COMPLETED'
    AND (category_filter IS NULL OR p.category_id = category_filter)
    AND (featured_only = FALSE OR p.is_featured = TRUE)
    ORDER BY p.display_order ASC, p.created_at DESC
    LIMIT page_size OFFSET offset_val;
END$$

-- Procédure pour obtenir les compétences par catégorie
CREATE PROCEDURE GetSkillsByCategory()
BEGIN
    SELECT 
        sc.name as category_name,
        JSON_ARRAYAGG(
            JSON_OBJECT(
                'id', s.id,
                'name', s.name,
                'level', s.level,
                'icon_url', s.icon_url,
                'description', s.description,
                'years_experience', s.years_experience,
                'is_featured', s.is_featured
            )
        ) as skills
    FROM skill_categories sc
    LEFT JOIN skills s ON sc.id = s.category_id
    GROUP BY sc.id, sc.name, sc.display_order
    ORDER BY sc.display_order ASC;
END$$

DELIMITER ;
