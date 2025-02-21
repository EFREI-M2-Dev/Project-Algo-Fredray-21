# Project-Algo-Fredray-21
## Frédéric Dabadie

# Analyse des Tweets - Détection de discours haineux

## **1. Présentation du Projet**

Ce projet vise à classifier les tweets en deux catégories : *haineux* et *non haineux* à l’aide d’un modèle de machine learning entraîné sur un jeu de données annoté.

Le modèle repose sur une **régression logistique** et utilise un prétraitement de texte simple basé sur **CountVectorizer**. L’API expose une interface permettant d’envoyer des tweets et de recevoir une analyse automatisée.

---

## **2. Installation et Déploiement**

### **Cloner le projet**

```sh
git clone https://github.com/EFREI-M2-Dev/Project-Algo-Fredray-21.git
cd Project-Algo-Fredray-21
```

### **Lancer le projet avec Docker**

Le projet utilise Docker pour gérer la base de données et l’API.

```sh
docker compose up -d
```

Cela démarre :

- **L’API Flask** accessible sur [http://localhost:8000](http://localhost:8000)
- **La base de données MySQL** contenant les tweets annotés, déjà initialisée avec une base, une table et des données grâce au `docker-compose.yml` :

```yaml
volumes:
  - mysql_data:/var/lib/mysql
  - ./database/tweets.sql:/docker-entrypoint-initdb.d/tweets.sql
```

- **Une tâche cron** entraînant le modèle périodiquement

### **Arrêter les services**

```sh
docker compose down
```

Pour supprimer les volumes associés :

```sh
docker compose down -v
```

---

## **3. API d’Analyse des Tweets**

L’API permet d’envoyer un tableau de tweets pour obtenir une analyse.

### **Example de requête avec postman**
Un example est disponible dans le `rapport_evaluation_frederic_dabadie.pdf`

### **Exemple de requête avec curl**

```sh
curl -X POST http://localhost:8000/analyze \
     -H "Content-Type: application/json" \
     -d '{
           "tweets": [
    "Il est le seul à s'opposer aux élites corrompues",
    "Il ose affronter le politiquement correct c'est rare aujourd'hui",
    "Son dernier discours était rempli de contradictions..."
           ]
         }'
```

### **Exemple de réponse JSON**

```json
{
    "Il est le seul à s'opposer aux élites corrompues": 0.509,
    "Il ose affronter le politiquement correct c'est rare aujourd'hui": 0.282,
    "Son dernier discours était rempli de contradictions...": -0.467
}
```

Un score proche de -1 indique un tweet haineux, tandis qu’un score proche de 1 indique un tweet non haineux.


### **Gestion des erreurs**
- Manque de la clée `tweets` dans le body :
```json
{
    "error": "Invalid input, expected JSON with 'tweets' key"
}
```

- Clée `tweets` de type autres que List (ex: `tweets:"un texte"`):
```json
{
    "error": "Invalid input, 'tweets' must be a list of strings"
}
```

- Liste vide (ex: `tweets:[]`):
```json
{
    "error": "Invalid input, 'tweets' must not be empty"
}
```

- Liste avec mauvais type (ex: `tweets:[1,2,3]`):
```json
{
    "error": "Invalid input, 'tweets' must be a list of strings"
}
```
---

## **4. Fonctionnement du Cron Job**

L’entraînement du modèle est automatisé grâce à une tâche cron exécutée chaque semaine.

### **Fichier Cron Job (**``**)**

```cron
0 3 * * 0 cd /app && /usr/local/bin/python /app/models_training.py >> /app/cron.log 2>&1 && pkill -HUP gunicorn
```

### **Explication**

- `0 3 * * 0` : Exécution **tous les dimanches à 3h du matin**
- `cd /app` : Se place dans le dossier de l’application
- `python /app/models_training.py` : Entraîne les modèles avec les nouvelles données
- `>> /app/cron.log 2>&1` : Sauvegarde les logs dans `cron.log`
- `pkill -HUP gunicorn` : Redémarre l’API pour utiliser les nouveaux modèles

---

### **Dans le conteneur**
Une fois dans le conteneur en cours d'exécution, nous pouvons constater que le job cron est bien enregistré et en attente d'exécution :

```sh
docker exec -it project-algo-fredray-21-api-1 bash  # On rentre dans le conteneur

root@a18738309090:/app# crontab -l                  # Affiche la liste des jobs cron enregistrés
0 3 * * 0 cd /app && /usr/local/bin/python /app/models_training.py >> /app/cron.log 2>&1 && pkill -HUP gunicorn
root@a18738309090:/app#
```


## **5. Structure du Projet**

```bash
.
├── models_training.py        # Script d'entraînement des modèles
├── main.py                   # API Flask pour l'analyse des tweets
├── database/
│   ├── tweets.sql            # Script SQL pour initialiser la BD
├── models/
│   ├── model_positif.pkl     # Modèle entraîné sur les tweets positifs
│   ├── model_negatif.pkl     # Modèle entraîné sur les tweets négatifs
│   ├── vectorizer.pkl        # Vectorizer pour le prétraitement du texte
├── cronjobs/
│   ├── models_training_cron  # Script cron d'entraînement automatique
├── docker-compose.yml        # Fichier Docker Compose
├── requirements.txt          # Liste des dépendances Python
├── start.sh                  # Script pour démarrer l’application
├── rapport_evaluation_frederic_dabadie.pdf # Rapport d’évaluation du modèle
├── Dockerfile                # Fichier Docker pour la création de l’image
├── .gitignore                # Fichier pour exclure certains fichiers du repo
└── README.md                 # Documentation
```

## **6. Schéma de la base MySQL**
La base de données MySQL contient une table nommée **tweets**, utilisée pour stocker les tweets annotés.  
Cette table sert de dataset pour entraîner le modèle.  
Structure de la table `tweets` :  
- **id** : Identifiant unique du tweet (clé primaire).
- **text** : Contenu du tweet.
- **positive** : Valeur binaire (1 ou 0) indiquant si le tweet est jugé positif (1) ou non (0).
- **negative** : Valeur binaire (1 ou 0) indiquant si le tweet est jugé négatif (1) ou non (0).

## **7. Auteurs**

- **[Frédéric Dabadie](https://github.com/Fredray-21)**

**Fin du document.**