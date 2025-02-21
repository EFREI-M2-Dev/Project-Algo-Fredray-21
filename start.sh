#!/bin/bash
# on start cron en arrière-plan
service cron start

# on start l'API
gunicorn -w 4 -b 0.0.0.0:8000 main:app
