# 23_Inception
Stephane Vogrig


### Resources
Docker

- [Docker](https://www.docker.com/)
- [Docker install engine](https://docs.docker.com/engine/install/ubuntu/)
- [Docker docs](https://docs.docker.com/)
- [Docker hub](https://hub.docker.com/)

Nginx

- [Running the NGINX in a Docker Container](https://hub.docker.com/)

## Tuto

### Server adress
Sur la machine virtuelle ajouter `127.0.0.1 svogrig.42.fr` au debut du fichier `/etc/hosts`

Dans le fichier de configuration de nginx modifier `server_name svogrig.42.fr;`

### [Mariadb](https://fr.wikipedia.org/wiki/MariaDB)
http://www.net6a.com/article32/docker-exemple-dockerfile
https://codepal.ai/dockerfile-writer/query/KiBsxvO1/dockerfile-mariadb-alpine

https://www.val-r.fr/geek/os/linux/installer-un-serveur-linux-sous-debian/installation-et-configuration-du-serveur-mysql-mariadb/

#### [Structured Query Language](https://fr.wikipedia.org/wiki/Structured_Query_Language)
- [sql.sh](https://sql.sh/cours/select)

#### Correction

- Se connecter a mariadb:
	```sh
	docker exec mariadb mariadb -u root -p
	```
- Voir la liste des database:
	```sql
	MariaDB [(none)]> show databases;
	```
- Utiliser une database:
	```sql
	MariaDB [(none)]> use <database name>;
	```
- Lister les tables d'une database:
	```sql
	MariaDB [inception]> show tables;
	```

- Afficher tous les champs et tous les enregistrements d'une table:
	```sql
	MariaDB [inception]> select * from wp_users;
	```

### [Wordpress](https://fr.wordpress.org/)
#### Installation
Links:
- [Comment installer WordPress](https://fr.wordpress.org/support/article/how-to-install-wordpress/)
- [Installer WordPress en 3 méthodes](https://wpformation.com/installer-wordpress/)

https://www.datanovia.com/en/fr/lessons/fichiers-dinstallation-de-docker-wordpress-exemple-pour-le-developpement-local/

#### Correction
- **Ajouter un commentaire a un blog**  
Et verifier apres redemarrage qu'il est present.
Pour cela il faut ajouter un commentaire sur le blog et le valider en tant qu'admin.
Pour se connecter comme admin on ajoute `/wp-admin` au chemin dans le navigateur :
```
https://login.42.fr:443/wp-admin
```
Renseigner nom d'utilisateur et mot de passe, la page dashboard apparait. Les commentaires en attentes sont dans le cadre activite (en bas a gauche).
- **modifier une page.**  
Et verifier apres redemarrage qu'elle est toujours modifiees.

## Bonus
### [Adminer](https://www.adminer.org/en/)

### [Redis]()
Links:  
- [Wikipedia - Redis](https://fr.wikipedia.org/wiki/Redis)
- [Run Redis Open Source on Docker](https://redis.io/docs/latest/operate/oss_and_stack/install/install-stack/docker/)
- [Setting up Redis on Alpine Linux](https://krython.com/post/setting-up-redis-on-alpine-linux)
utilisation avec redis-cli:
redis-cli -h 127.0.0.1 -p 6380
Une fois connecté, tu peux exécuter des commandes Redis simples, par exemple :

ping (devrait répondre PONG)

set mykey "Hello Redis"

get mykey (devrait retourner "Hello Redis")

exit pour quitter.

## [cAdvisor](https://github.com/google/cadvisor)
links: 
- [medium](https://medium.com/@varunjain2108/monitoring-docker-containers-with-cadvisor-prometheus-and-grafana-d101b4dbbc84)

## ftp

ftp localhost