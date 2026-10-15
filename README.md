# Jenkins CI/CD — Spring Boot, Docker et Kubernetes

## Présentation

Ce projet présente la mise en place d'un environnement DevOps autour de Jenkins, avec l'automatisation de builds, la gestion du code source avec Git et le déploiement d'une application Spring Boot sur Kubernetes via Minikube.

Le travail couvre également la configuration d'un job Jenkins de type Freestyle, l'exécution périodique des builds et la vérification du déploiement de l'application.

## Objectifs

- Comprendre le fonctionnement de Jenkins et des jobs Freestyle.
- Intégrer un dépôt Git dans Jenkins.
- Compiler et exécuter une application Java.
- Automatiser les builds et vérifier leurs résultats.
- Conteneuriser une application Spring Boot avec Docker.
- Déployer l'application sur Kubernetes avec Minikube.
- Documenter les résultats à l'aide de captures d'écran.

## Environnement technique

- **CI/CD :** Jenkins
- **Gestion de versions :** Git et GitHub
- **Langage :** Java
- **Framework :** Spring Boot
- **Build :** Maven / compilation Java selon le job
- **Conteneurisation :** Docker
- **Orchestration :** Kubernetes
- **Cluster local :** Minikube
- **Outils Kubernetes :** kubectl

## Étapes réalisées

### 1. Création d'un job Freestyle Jenkins

Un job Freestyle a été créé afin d'exécuter des commandes shell et de vérifier le fonctionnement de l'environnement Jenkins.

Le job exécute notamment des commandes de diagnostic et crée un fichier de test.

### 2. Exécution du programme Java

Le job compile et exécute le fichier `Test.java`. Le résultat est consultable dans la console du build Jenkins.

### 3. Intégration Git

Le dépôt Git est configuré comme source du projet. Jenkins récupère le code depuis la branche `main`, puis exécute les étapes de build.

### 4. Automatisation périodique

Une planification Jenkins a été configurée avec l'expression cron :

```text
H/5 * * * *
```

Cette expression demande une exécution approximativement toutes les cinq minutes, selon la planification Jenkins et la disponibilité du nœud d'exécution.

L'option de suppression de l'espace de travail avant le build a également été configurée.

### 5. Déploiement sur Kubernetes

L'application Spring Boot a été déployée dans Minikube avec un Deployment de deux réplicas.

Le Service Kubernetes `spring-app-service` a été créé de type `NodePort`. L'application a répondu avec le code HTTP `200` lors d'un test effectué avec `curl`.

Résultats observés :

- Deployment : `spring-app-deployment`
- Réplicas disponibles : `2/2`
- Pods : `Running`
- Service : `spring-app-service`
- NodePort observé : `30517`
- Réponse HTTP : `200 OK`

### 6. Vérification des builds

Les builds Jenkins `#12` et `#13` ont été observés avec un statut réussi dans l'interface Jenkins.



Afficher les nœuds :

```bash
kubectl get nodes
```

Afficher le Deployment :

```bash
kubectl get deployments
```

Afficher les Pods :

```bash
kubectl get pods -o wide
```

Afficher les Services :

```bash
kubectl get services
```

Tester l'application depuis le serveur :

```bash
curl -i http://$(minikube ip):30517
```

## Résultats

Les builds Jenkins documentés ont réussi. Le Deployment Kubernetes dispose de deux réplicas prêts et l'application a retourné une réponse HTTP `200` lors du test de connectivité.

La mise en place constitue une base pratique pour approfondir l'intégration continue, la livraison continue et l'automatisation du déploiement.

## Améliorations possibles

- Construire automatiquement l'image Docker à chaque modification du code.
- Publier l'image dans un registre de conteneurs.
- Déclencher les builds à l'aide d'un webhook GitHub.
- Automatiser le déploiement Kubernetes depuis Jenkins.
- Ajouter des tests automatisés et des contrôles de sécurité.
- Gérer les credentials via Jenkins Credentials, sans les stocker dans le dépôt.

## Sécurité

Aucun mot de passe Jenkins, token GitHub, clé privée SSH ou secret d'accès ne doit être publié dans ce dépôt.

Les captures doivent masquer les informations d'authentification et les données sensibles.

## Auteur

Amin Najjar

Projet pratique DevOps / CI-CD — Jenkins, Docker et Kubernetes.
