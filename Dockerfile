FROM python:3.10

WORKDIR /app

# on installe les dependances systeme (cron et dos2unix)
RUN apt-get update && apt-get install -y cron dos2unix

# on copie le fichier des dependances python
COPY requirements.txt . 

# on installe les dependances python
RUN pip install --no-cache-dir -r /app/requirements.txt

# on copie les models par defaut
COPY models/ models/

# on copie le script main.py (API)
COPY main.py .

# on copie le script models_training.py (entrainement des models)
COPY models_training.py .

# on copie le script start.sh
COPY ./start.sh .

# on copie le script models_training_cron (CRON JOB)
COPY ./cronjobs/models_training_cron /etc/cron.d/models_training

# on convertit le fichier en format UNIX (on retire le \r des fins de lignes)
RUN dos2unix /etc/cron.d/models_training

# on donne les droits d'execution au script start.sh
RUN chmod 0644 /etc/cron.d/models_training

# on ajoute la tache cron
RUN crontab /etc/cron.d/models_training

# Lancer le script start.sh pour démarrer cron et l'API
CMD ["/app/start.sh"]
