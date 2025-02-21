from flask import Flask, request, jsonify
import joblib
import re

app = Flask(__name__)

try:
    # Charger les modèles et le vectorizer
    model_positif = joblib.load("./models/model_positif.pkl")
    model_negatif = joblib.load("./models/model_negatif.pkl")
    vectorizer = joblib.load("./models/vectorizer.pkl")
except FileNotFoundError as e:
    print(f"Erreur de chargement du modèle : {e}")
    print("Assurez-vous que les fichiers 'model_positif.pkl', 'model_negatif.pkl' et 'vectorizer.pkl' sont présents.")
    print("Vous pouvez les générer en exécutant le script 'models_training.py'.")
    exit(1)


# Fonction de nettoyage du texte 
def clean_text(text):
    text = text.lower()
    text = re.sub(r'[^\w\s]', '', text)
    return text

@app.route('/analyze', methods=['POST'], strict_slashes=False)
def analyze_sentiment():
    data = request.get_json()
    if not data or 'tweets' not in data:
        return jsonify({"error": "Invalid input, expected JSON with 'tweets' key"}), 400
    
    tweets = data['tweets']
    
    if not isinstance(tweets, list):
        return jsonify({"error": "Invalid input, 'tweets' must be a list of strings"}), 400
    
    if len(tweets) == 0:
        return jsonify({"error": "Invalid input, 'tweets' must not be empty"}), 400
    
    if not all(isinstance(tweet, str) for tweet in tweets):
        return jsonify({"error": "Invalid input, 'tweets' must be a list of strings"}), 400
    
    # ici on clean les tweets et on les vectorize
    tweets_clean = [clean_text(tweet) for tweet in tweets]
    tweets_vectorized = vectorizer.transform(tweets_clean)
    
    # on calcule les probabilités de chaque classe
    prob_positif = model_positif.predict_proba(tweets_vectorized)[:, 1]
    prob_negatif = model_negatif.predict_proba(tweets_vectorized)[:, 1]
    
    # on calcule le score final
    scores = prob_positif - prob_negatif
    
    # retour des scores sous forme de {tweet: score}
    return jsonify({tweet: round(score, 3) for tweet, score in zip(tweets, scores)})

if __name__ == '__main__':
    app.run(debug=False)
