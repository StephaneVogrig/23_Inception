## Docker

### Connaitre la version de docker
```sh
docker -v
```
### Gestion des images

```sh
docker image ls
docker images
```
```sh
docker image rm <image>
docker rmi <image>
```

```sh
docker run --name container_name -d <image>
```

```sh
docker run -it --rm <image>
```
### Dockerfile
Construire une image avec un nom a partir du Dockerfile dans le dossier courant
```sh
docker build -t <container name> .
```


### Gestion des conteneur
Lister les conteneurs actif
```sh
docker container ls
docker ps
```
Lister tous les conteneurs
```sh
docker ps -a
```

```sh
docker rm <container>
```

```sh
docker start <container>
```

```sh
docker stop <container>
```


```sh
docker system prune -af
```

```sh
docker system prune -af --volumes
```

```sh
docker exec -it <container>
```




## Wordpress

## Mariadb

docker exec -it mariadb sh

mariadb -u root -p

