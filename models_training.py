import re
import joblib
import mysql.connector
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix

# on charge les données depuis la base de données en fonction si c'est positif ou négatif
def load_data_from_db(is_positive):
    conn = mysql.connector.connect(
        host="db",                  # Nom du service dans le docker-compose.yml
        user="user",                # Utilisateur MySQL par défaut dans le Dockerfile
        password="password",        # Mot de passe MySQL par défaut dans le Dockerfile
        database="tweets_db"        # Nom de la base de données
    )
    cursor = conn.cursor()
    string_is_positive = 'positive' if is_positive else 'negative'
    query = f"SELECT text, {string_is_positive} FROM tweets"
    cursor.execute(query)
    
    rows = cursor.fetchall()
    print(f"Chargement des données ({string_is_positive}) : {len(rows)} lignes")
    df = pd.DataFrame(rows, columns=['text', string_is_positive])

    cursor.close()
    conn.close()
    return df

# Fonction de nettoyage du texte pour le rendre plus simple à traiter
def clean_text(text):
    text = text.lower()
    text = re.sub(r'[^\w\s]', '', text)
    return text


# Liste de mots vides en français
french_stopwords = [
    "le", "la", "les", "un", "une", "des", "du", "de", "dans", "et", "en", "au",
    "aux", "avec", "ce", "ces", "pour", "par", "sur", "pas", "plus", "où", "mais",
    "ou", "donc", "ni", "car", "ne", "que", "qui", "quoi", "quand", "à", "son",
    "sa", "ses", "ils", "elles", "nous", "vous", "est", "sont", "cette", "cet",
    "aussi", "être", "avoir", "faire", "comme", "tout", "bien", "mal", "on", "lui"
]


# Charger les données depuis MySQL 
df_positif = load_data_from_db(True) # Positif
df_negatif = load_data_from_db(False) # Négatif

# Appliquer le nettoyage sur toute les rows de la colonne 'text'
df_positif['text_clean'] = df_positif['text'].apply(clean_text)
df_negatif['text_clean'] = df_negatif['text'].apply(clean_text)

# Vectorisation
vectorizer = CountVectorizer(stop_words=french_stopwords, max_features=100)
X_positif = vectorizer.fit_transform(df_positif['text_clean'])
X_negatif = vectorizer.fit_transform(df_negatif['text_clean'])
y_positif = df_positif['positive']
y_negatif = df_negatif['negative']

# Division des données
X_train_positif, X_test_positif, y_train_positif, y_test_positif = train_test_split(X_positif, y_positif, test_size=0.25, random_state=42)
X_train_negatif, X_test_negatif, y_train_negatif, y_test_negatif = train_test_split(X_negatif, y_negatif, test_size=0.25, random_state=42)

# Entraînement du modèle
model_positif = LogisticRegression()
model_negatif = LogisticRegression()

model_positif.fit(X_train_positif, y_train_positif)
model_negatif.fit(X_train_negatif, y_train_negatif)

# Evaluation du modèle
y_pred_positif = model_positif.predict(X_test_positif)
y_pred_negatif = model_negatif.predict(X_test_negatif)

print("Rapport de classification (positif) :")
print(classification_report(y_test_positif, y_pred_positif))
print("Matrice de confusion (positif) :")
print("1 = Non haineux, 0 = Haineux")
print(confusion_matrix(y_test_positif, y_pred_positif))

print("Rapport de classification (négatif) :")
print(classification_report(y_test_negatif, y_pred_negatif))
print("Matrice de confusion (négatif) :")
print("1 = Haineux, 0 = Non haineux")
print(confusion_matrix(y_test_negatif, y_pred_negatif))

# Sauvegarde du modèle
joblib.dump(model_positif, "./models/model_positif.pkl")
joblib.dump(model_negatif, "./models/model_negatif.pkl")
joblib.dump(vectorizer, "./models/vectorizer.pkl")
print("Modèle sauvegardé avec succès.")