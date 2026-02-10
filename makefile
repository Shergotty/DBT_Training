all : up down shell document
.PHONY : all

up:
	docker compose up -d
down:
	docker compose down -v
shell:
	./shell.sh
document:
	dbt docs generate
	dbt docs serve
