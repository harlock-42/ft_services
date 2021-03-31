
`docker build .` permit to create and set an image

options :

`--rm` Remove intermediate containers after a successful build

`-t` Set the name of the image
`--tag` Set the tag of image's name (NAME:TAG)

`docker run IMAGE_NAME` permit to create a contener with the image

options :

`-p` Publish (or map) a container's port (or several) to the host

`-w` set the workdir of the containers

`--name` assign a name to the container



# run, create and delete a contener

to stop a contener the `stop` comand is better than `kill' comand. The first one is less violent

to delete a contener

1 --> `docker stop UID`
2 --> `docker rm UID`

to delete all the contener
```
docker rm -f $(docker ps -a -q)

to get contener's UID --> `docker ps`

to create a contener without run it --> `docker create UID`
Then to run it `docker start UID`

# Get to contener and modify it

```
docker exec -t -i CONTENER_NAME /bin/bash
```
Create a fake terminal with wich you can navigate and modify your contener. Your contener has to be start or run.

```docker inspect CONTENER_NAME``` displays informations about contener with a Json file.

# Images

```docker images``` display images's list
```docker rmi IMAGE_UUID``` delete an image

## dispay images
```
docker images
```

# Launch a contener

exemple :
```
docker run -p 8000:80 --name CONTENER_NAME -d IMAGE_NAME .
```

```-p``` HOST_PORT:CONTENER_PORT is to map contener's port to the host machin. You can have several time the -p option in one run to mapped different ports.

`--name CONTENER_NAME` give a name to the contener

`-d` the contener are going to be executing in deamon mode

`IMAGE_NAME` build the contener with an image existing or not

# Dockerfile

## COPY

replace a file in the contener with a file from the host machin

## ENTRYPOINT

Launch a comand when the image is run. It's not executed during the bulding of the image.

Two way to use :

`ENTRYPOINT comand`

`EBTRYPOINT ["executable", "param 1", "param 2"]`

## EXPOSE


`EXPOSE 80 30080`
Expose the contener's ports to make them reachable by the host machin's ports.

## apk

`apk update`
`apk add` install

# Docs

All cli docker's comand

[Docker cli](https://docs.docker.com/engine/reference/commandline/run/)
