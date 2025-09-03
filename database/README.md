# 🗄️ Base de Données Portfolio (MySQL)

Ce dossier contient la base de données pour votre portfolio. **Pas de panique !** Tout est automatisé avec Docker.

## � Démarrage Ultra-Rapide (Débutants)

### Étape 1 : Prérequis
1. **Installer Docker Desktop** : [Télécharger ici](https://www.docker.com/products/docker-desktop/)
2. **Démarrer Docker Desktop** : Ouvrir l'application et attendre qu'elle soit prête
3. **Ouvrir un terminal** dans ce dossier `database`

### Étape 2 : Lancer votre base de données
```bash
# Une seule commande pour tout faire !
docker-compose up -d
```

### Étape 3 : Vérifier que ça marche
1. **Aller sur** http://localhost:8080 (phpMyAdmin)
2. **Se connecter avec :**
   - Serveur : `mysql`
   - Utilisateur : `portfolio_user`
   - Mot de passe : `portfolio_password`
3. **Vous devriez voir** vos tables créées automatiquement !

## 🎉 C'est tout ! Votre base de données est prête

Vous avez maintenant :
- ✅ Une base MySQL qui tourne
- ✅ Toutes vos tables créées
- ✅ Des données d'exemple
- ✅ Une interface graphique (phpMyAdmin)

## � Que contient votre base de données ?

### 📋 **Tables principales** (créées automatiquement)
- **`projects`** → Vos projets de portfolio
- **`skills`** → Vos compétences techniques  
- **`experiences`** → Votre parcours professionnel
- **`contacts`** → Messages reçus via votre site
- **`users`** → Compte admin pour gérer le contenu

### 🎯 **Données d'exemple incluses**
- Quelques projets d'exemple
- Compétences Java, React, MySQL
- Expériences professionnelles
- Un compte admin (username: `admin`, password: `admin123`)

## 🛠️ Commandes Docker Utiles

```bash
# Voir si vos containers tournent
docker-compose ps

# Voir les logs si problème
docker-compose logs mysql

# Arrêter tout
docker-compose down

# Redémarrer
docker-compose up -d

# ATTENTION : Supprimer toutes les données
docker-compose down -v
```

## � Installation Recommandée (Docker)

### Prérequis
- Docker Desktop installé et démarré
- Docker Compose disponible

### Démarrage rapide
```bash
# Dans le dossier database
docker-compose up -d

# Vérifier que les containers tournent
docker-compose ps

# Voir les logs si nécessaire
docker-compose logs mysql
```

### Accès aux services
- **MySQL** : `localhost:3307`
- **phpMyAdmin** : http://localhost:8080
  - Utilisateur : `portfolio_user`
  - Mot de passe : `portfolio_password`

### Commandes utiles
```bash
# Arrêter les services
docker-compose down

# Redémarrer (avec rebuild)
docker-compose up -d --build

# Supprimer tout (données incluses)
docker-compose down -v
```

## 🔧 Configuration pour le Développement

### Variables d'environnement recommandées
```env
DB_HOST=localhost
DB_PORT=3307
DB_NAME=portfolio_db
DB_USER=portfolio_user
DB_PASSWORD=portfolio_password
```

### Connexion JDBC (pour Spring Boot)
```properties
spring.datasource.url=jdbc:mysql://localhost:3307/portfolio_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=portfolio_user
spring.datasource.password=portfolio_password
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
spring.jpa.hibernate.ddl-auto=validate
```

## 📊 Vues Disponibles

- **`projects_with_category`** : Projets avec informations de catégorie
- **`skills_with_category`** : Compétences organisées par catégorie
- **`experiences_formatted`** : Expériences avec durée calculée
- **`portfolio_stats`** : Statistiques générales
- **`recent_projects`** : 6 projets les plus récents

## 🔍 Procédures Stockées Disponibles

- **`GetProjectsPaginated()`** : Pagination des projets avec filtres
- **`GetSkillsByCategory()`** : Compétences groupées par catégorie
- **`SearchProjects()`** : Recherche textuelle dans les projets
- **`GetDashboardStats()`** : Statistiques pour le dashboard admin
- **`MarkContactAsRead()`** : Marquer un message comme lu

## 🔒 Sécurité

- Mots de passe hashés avec SHA2-256 (MySQL natif)
- UUID pour tous les IDs
- Contraintes de validation avec ENUM
- Indexes pour les performances
- Clés étrangères avec CASCADE

## 📝 Notes Importantes

1. **Mot de passe admin par défaut** : `admin123` (À CHANGER EN PRODUCTION!)
2. **Données d'exemple** : Le script inclut des données de test
3. **JSON** : Utilisé pour stocker les arrays (technologies, achievements)
4. **Triggers automatiques** : Mise à jour automatique des timestamps avec `ON UPDATE CURRENT_TIMESTAMP`

## 🔄 Maintenance

### Sauvegarde
```bash
mysqldump -u portfolio_user -p portfolio_db > backup_$(date +%Y%m%d).sql
```

### Restauration
```bash
mysql -u portfolio_user -p portfolio_db < backup_YYYYMMDD.sql
```

## 🐳 Docker Quick Start (Méthode Recommandée)

```bash
# 1. Démarrer tous les services
cd database
docker-compose up -d

# 2. Vérifier que tout fonctionne
docker-compose ps

# 3. Accéder à phpMyAdmin
# http://localhost:8080
# User: portfolio_user, Password: portfolio_password

# 4. Tester la connexion depuis votre application
# Host: localhost:3307
```

### Gestion des containers
```bash
# Voir les logs
docker-compose logs -f mysql

# Arrêter les services
docker-compose down

# Redémarrer
docker-compose restart

# Supprimer complètement (données incluses)
docker-compose down -v
```

## 🌟 Avantages de MySQL pour ce projet

- **Performance** : Excellent pour les applications web
- **Compatibilité** : Large support par les hébergeurs
- **Outils** : phpMyAdmin, MySQL Workbench
- **Spring Boot** : Intégration native parfaite
- **JSON** : Support natif des types JSON depuis MySQL 5.7+
