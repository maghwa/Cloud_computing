#!/bin/bash

# Vérifier si Docker est installé
if ! command -v docker &> /dev/null; then
    echo "Docker non trouvé. Installation de Docker..."
    
    # Mise à jour des paquets
    sudo apt-get update -y

    # Installer les dépendances pour Docker
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Ajouter la clé GPG officielle de Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Ajouter le dépôt Docker à APT
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # Mettre à jour à nouveau les paquets pour inclure Docker
    sudo apt-get update -y

    # Installer Docker
    sudo apt-get install -y docker-ce

    # Activer et démarrer Docker
    sudo systemctl enable docker
    sudo systemctl start docker

    echo "Docker installé avec succès."
else
    echo "Docker est déjà installé."
fi

# Vérifier si l'application Docker est spécifiée
if [ -z "$1" ]; then
    echo "Erreur : Aucun nom d'application ou image Docker fourni."
    echo "Utilisation : $0 <nom_image_docker>"
    exit 1
fi

DOCKER_IMAGE="golucky5/pacman"

# Télécharger et exécuter l'application Docker
echo "Téléchargement et exécution de l'image Docker : $DOCKER_IMAGE"

sudo docker pull $DOCKER_IMAGE
sudo docker run -d --name app_container -p 8080:80 $DOCKER_IMAGE

echo "Application Docker déployée et accessible sur http://<server-ip>:8080"
