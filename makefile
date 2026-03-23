all : up down sh ps1 dev compile docs serve
.PHONY : all up down sh ps1 dev compile docs serve

# --- VARIABLES ---
DC := docker compose
DBT_EXEC := $(DC) exec dbt_python dbt
DBT_EXEC_BG := $(DC) exec -d dbt_python dbt

# --- INFRASTRUCTURE ---
up:
	$(DC) up -d

down:
	-$(DBT_EXEC) clean
	$(DC) down -v

# --- SHELLS ---
sh:
	@echo "Opening interactive shell..."
	./shell.sh

ps1:
	@echo "Opening interactive PowerShell..."
	./shell.ps1

# --- DBT COMMANDS ---
compile:
	@echo "Compiling dbt project..."
	$(DBT_EXEC) compile

docs:
	@echo "Generating dbt docs..."
	$(DBT_EXEC) docs generate

serve:
	@echo "Starting dbt docs server in the background on port 8080..."
	$(DBT_EXEC_BG) docs serve --host 0.0.0.0 --port 8080

# --- WORKFLOWS ---
# Runs the whole workflow: compile, generate docs, serve in background, and open shell
dev: compile docs serve sh