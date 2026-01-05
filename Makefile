
DOCKER_COMPOSE_FILE ?= docker-compose.yml
DOCKER_COMPOSE ?= docker compose
UTILITY := utility

# Well documented Makefiles
DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo ""
	@echo "=== Setup ==="
	@echo "  make config              - Install default config to alpha-core"
	@echo "  make setup-all           - Run config, db-setup, and up"
	@echo "  make external_db         - Switch to external DB and disable local sql"
	@echo "  make internal_db         - Switch to local sql and enable localdb profile"
	@echo ""
	@echo "=== Database ==="
	@echo "  make db-user             - Create DB user (if not root)"
	@echo "  make db-create           - Create databases"
	@echo "  make db-drop             - Drop databases"
	@echo "  make db-populate         - Populate databases (schema only)"
	@echo "  make db-update           - Apply database updates"
	@echo "  make db-setup            - Create, populate, then update databases"
	@echo "  make db-backup           - Backup databases (optional BACKUP=folder)"
	@echo "  make db-restore          - Restore databases (optional BACKUP=folder)"
	@echo ""
	@echo "=== Docker ==="
	@echo "  make up                  - Build and start all containers"
	@echo "  make start               - Start all containers"
	@echo "  make stop                - Stop all containers (not dev)"
	@echo "  make restart             - Restart all containers (not dev)"
	@echo "  make down                - Stop and remove containers (not dev)"
	@echo "  make build-utility       - Build utility image"
	@echo "  make connect <name>      - Connect to container"
	@echo "  make list                - List running containers"
	@echo ""
	@echo "=== Logs ==="
	@echo "  make log <name>          - Show container log"
	@echo "  make logs                - Show all containers logs"

##@ [Run Firsttime]
.PHONY: config
config: ## Install default config to alpha-core
	@if [ -e etc/config/config.yml ] && [ ! -w etc/config/config.yml ]; then \
		echo "etc/config/config.yml is not writable; run: sudo chown $$USER:$$USER etc/config/config.yml"; \
		exit 1; \
	fi
	@cp etc/config/config.yml.dist etc/config/config.yml
	@echo "Config installed to etc/config/config.yml"

setup-all: ## Run config, db-setup, and up
	$(MAKE) config
	$(MAKE) db-setup
	$(MAKE) up

external_db: ## Switch to external DB and disable local sql
	@set -a; . ./.env; set +a; python3 etc/docker/external_db.py

internal_db: ## Switch to local sql and enable localdb profile
	@set -a; . ./.env; set +a; python3 etc/docker/internal_db.py
##@ [Database]
db-create: build-utility db-start-local db-user ## Create databases
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/create_databases.sh

db-drop: build-utility db-start-local ## Drop databases
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/drop_databases.sh

db-populate: build-utility db-start-local ## Populate databases (schema only)
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/populate_databases.sh

db-update: build-utility db-start-local ## Apply database updates
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/update_databases.sh

db-setup: ## Create, populate, then update databases
	$(MAKE) db-create
	$(MAKE) db-populate
	$(MAKE) db-update

db-backup: build-utility db-start-local ## Backup databases (optional BACKUP=folder)
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/backup_db.sh

db-restore: build-utility db-start-local ## Restore databases (optional BACKUP=folder)
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/restore_db.sh

##@ [Docker]
build-utility: ## Build utility image
	$(DOCKER_COMPOSE) build $(UTILITY)

db-user: build-utility db-start-local ## Create DB user (if not root)
	$(DOCKER_COMPOSE) run --rm $(UTILITY) /bin/commands/create_db_user.sh

db-start-local: ## Start local sql if MYSQL_HOST=sql
	@set -a; . ./.env; set +a; \
	if [ "$$MYSQL_HOST" = "sql" ] || [ "$$MYSQL_HOST" = "127.0.0.1" ] || [ "$$MYSQL_HOST" = "localhost" ]; then \
		$(DOCKER_COMPOSE) up -d sql; \
		echo "Waiting for sql to be ready..."; \
		host="$$MYSQL_HOST"; \
		port="$$MYSQL_PORT"; \
		if [ "$$MYSQL_HOST" = "sql" ]; then \
			host="127.0.0.1"; \
			port="$$MYSQL_HOST_PORT"; \
		fi; \
		i=0; \
		while [ $$i -lt 30 ]; do \
			if bash -c "</dev/tcp/$$host/$$port" >/dev/null 2>&1; then \
				echo "sql is ready."; \
				break; \
			fi; \
			i=$$((i+1)); \
			sleep 2; \
		done; \
		if [ $$i -ge 30 ]; then \
			echo "Timed out waiting for sql."; \
			exit 1; \
		fi; \
	fi

up: ## Build and start all containers
	$(DOCKER_COMPOSE) up -d

start: ## Start all containers
	$(DOCKER_COMPOSE) start

stop: ## Stop all containers (not dev)
	$(DOCKER_COMPOSE) stop

restart: ## Restart all containers (not dev)
	$(DOCKER_COMPOSE) restart

down: ## Stop and remove containers (not dev)
	$(DOCKER_COMPOSE) down

connect: ## Connect to container. usage: make connect <container>
	docker exec -it $(filter-out $@,$(MAKECMDGOALS)) /bin/sh

list: ## List all runnning containers
	docker ps -a --format="table {{.Names}}\t{{.Image}}\t{{.Status}}"

##@ [Logs]
log: ## show one contaienr log. usage: make log <contai ner>
	docker logs $(filter-out $@,$(MAKECMDGOALS)) -f

logs: ## Show all containers logs
	$(DOCKER_COMPOSE) logs -f
