all : up down shell document
.PHONY : all

up:
	docker compose up -d
down:
	docker compose down -v
sh:
	./shell.sh
ps1:
	./shell.ps1
document:
	dbt docs generate
	dbt docs serve
