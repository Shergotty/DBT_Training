all : up down sh ps1 
.PHONY : all

up:
	docker compose up -d
down:
	docker compose down -v
sh:
	./shell.sh
ps1:
	./shell.ps1