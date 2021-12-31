PROJECT = docker-rubin_sim

# Note, if you change this, you also need to update docker-compose.yml
SERVICE := rubinsim

# List of all containers
DOCKER_CONTAINER_LIST := $(shell docker ps -a -q)

# List of all images
DOCKER_IMAGE_LIST := $(shell docker images -q)

# List of all volumes
DOCKER_VOLUME_LIST := $(shell docker volume ls -q)

all: build test shell

# all targets are phony
.PHONY: help build run prune clean

help:
	@echo ''
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build   		 	build the docker image for rubinsim'
	@echo '  test				create a container from the rubinsim image and run a test script'
	@echo '  shell				open a bash shell to  rubinsim'
	@echo '  clean    			remove all docker images, containers and volumes'
	@echo '  clean-containers   remove all docker containers'
	@echo '  clean-images    	remove all docker images'
	@echo '  clean-volumes    	remove all docker volumes'
	@echo '  prune    			shortcut for docker system prune -af. Cleanup all inactive containers and cache.'

build:
	# build the LSST image from the Docker file (--no-cache , --progress=plain)
	docker build --no-cache -t leanne/$(SERVICE) .

test:
	#  start a container on the image, run the test script.
	docker run -it leanne/$(SERVICE)

shell:
	# bash into a running rubin_sim environment container
	docker run -it --rm leanne/$(SERVICE) /bin/bash -l

prune:
	# clean everything that is not actively used
	docker system prune -af

clean: clean-containers clean-images clean-volumes

clean-containers:
	# force stop and remove *all* containers
	@if [ -n "$(DOCKER_CONTAINER_LIST)" ]; \
    then \
    	echo "Removing docker containers" && \
    	 docker stop $(DOCKER_CONTAINER_LIST) && \
    	 docker rm $(DOCKER_CONTAINER_LIST); \
	else echo "No containers found"; \
 	fi;
clean-images:
	# force stop and remove *all* images
	@if [ -n "$(DOCKER_IMAGE_LIST)" ]; \
	then \
		echo "Removing docker images" && docker rmi --force $(DOCKER_IMAGE_LIST); \
	else echo "No images found"; \
	fi;
clean-volumes:
	# force stop and remove *all* volumes
	@if [ -n "$(DOCKER_VOLUME_LIST)" ]; \
	then \
		echo "Removing docker volumes" && docker volume rm  $(DOCKER_VOLUME_LIST); \
	else echo "No volumes found"; \
	fi;