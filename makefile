all : up down sh ps1 dev
.PHONY : all up down sh ps1 dev compile docs

up:
	docker compose up -d

down:
	-docker compose exec dbt_python dbt clean
	docker compose down -v

# Opens an interactive shell in the running container
sh:
	./shell.sh

ps1:
	./shell.ps1

# --- NEW COMMANDS ---

# Just compiles the dbt project using the running container
compile:
	docker compose exec dbt_python dbt compile

# Runs the whole workflow: compile, generate docs, serve in background, and open shell
dev: compile
	@echo "Generating dbt docs..."
	docker compose exec dbt_python dbt docs generate
	@echo "Starting dbt docs server in the background on port 8080..."
	docker compose exec -d dbt_python dbt docs serve --host 0.0.0.0 --port 8080
	@echo "Opening interactive shell..."
	./shell.sh