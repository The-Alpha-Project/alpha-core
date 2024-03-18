
DOCKER_COMPOSE_FILE ?= docker-compose.yml

# Well documented Makefiles
DEFAULT_GOAL := help

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-40s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ [Run Firsttime]
config: ## Install default config to alpha-core
	cp etc/config/config.yml.dist etc/config/config.yml

##@ [Docker]
up: ## Build and start all containers
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

start: ## Start all containers
	docker compose -f $(DOCKER_COMPOSE_FILE) start

stop: ## Stop all containers (not dev)
	docker compose -f $(DOCKER_COMPOSE_FILE) stop

down: ## Stop and remove containers (not dev)
	docker compose -f $(DOCKER_COMPOSE_FILE) down

build: ## Just build all docker images
	docker compose -f $(DOCKER_COMPOSE_FILE) build

connect: ## Connect to container. usage: make connect <container>
	docker exec -it $(filter-out $@,$(MAKECMDGOALS)) /bin/sh

list: ## List all runnning containers
	docker ps -a --format="table {{.Names}}\t{{.Image}}\t{{.Status}}"

##@ [Logs]
log: ## show one contaienr log. usage: make log <container>
	docker logs $(filter-out $@,$(MAKECMDGOALS)) -f

all_logs: ## Show all containers logs
	docker-compose logs -f
 
##@ [Profiles: dev]
up-dev: ## Build and start dev profile with PhpMyAdmin, Inotify (run it after make up)
	docker compose -f $(DOCKER_COMPOSE_FILE) --profile dev up -d

start-dev: ## Start built containers in dev profile
	docker start alpha-core-phpmyadmin-1 alpha-core-inotify-1
	
stop-dev: ## Stop built containers in dev profile
	docker stop alpha-core-phpmyadmin-1 alpha-core-inotify-1

down-dev: ## Stop and remove dev profile containers
	docker stop alpha-core-phpmyadmin-1 alpha-core-inotify-1
	docker rm alpha-core-phpmyadmin-1 alpha-core-inotify-1