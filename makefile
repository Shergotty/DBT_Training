all : up down sh ps1 docs
.PHONY : all

up:
	docker compose up -d
down:
	docker compose down -v
sh:
	./shell.sh
ps1:
	./shell.ps1

docs:
	dbt docs generate
	dbt docs serve --port 8080 --host 0.0.0.0