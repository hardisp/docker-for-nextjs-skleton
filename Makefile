PROJECT_NAME=skeleton-nextjs
COMPOSE_FILE=docker/docker-compose.yml

.PHONY: help dev prod build down restart logs clean

help:
	@echo "Available commands:"
	@echo "  make dev        -> Run development mode"
	@echo "  make prod       -> Run production mode"
	@echo "  make build      -> Build production image"
	@echo "  make down       -> Stop all containers"
	@echo "  make restart    -> Restart production container"
	@echo "  make logs       -> Show logs"
	@echo "  make clean      -> Remove containers and volumes"

dev:
	docker compose -f $(COMPOSE_FILE) --profile dev up

prod:
	docker compose -f $(COMPOSE_FILE) --profile prod up -d

build:
	docker compose -f $(COMPOSE_FILE) --profile prod build

down:
	docker compose -f $(COMPOSE_FILE) down

restart:
	docker compose -f $(COMPOSE_FILE) --profile prod up -d --build

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

clean:
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans

# End of Makefile
