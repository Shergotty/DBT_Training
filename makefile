all : up down shell dev compile docs serve
.PHONY : all up down shell dev compile docs serve

# --- VARIABLES ---
DC := docker compose
PYYTHON_DBT := dbt_python dbt
DBT_EXEC := $(DC) exec $(PYYTHON_DBT)
DBT_EXEC_BG := $(DC) exec -d $(PYYTHON_DBT)

# --- SHELL DETECTION ---
# Default to shell script for Mac/Linux
SCRIPT_RUNNER := ./shell.sh

# Check if we are on Windows
ifeq ($(OS),Windows_NT)
	# Explicitly call powershell to execute the script
	SCRIPT_RUNNER := powershell -ExecutionPolicy Bypass -File .\shell.ps1
	
	# Override back to standard bash execution if running inside Git Bash / MSYS2
	ifdef MSYSTEM
		SCRIPT_RUNNER := ./shell.sh
	endif
endif

# ... (keep your other targets the same) ...

# --- UNIFIED SHELL COMMAND ---
shell:
	@echo "Opening interactive shell..."
	$(SCRIPT_RUNNER)

# --- INFRASTRUCTURE ---
up:
	$(DC) up -d

down:
	-$(DBT_EXEC) clean
	$(DC) down -v

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
# Notice we updated 'sh' to 'shell' at the end of this chain!
dev: compile docs serve shell