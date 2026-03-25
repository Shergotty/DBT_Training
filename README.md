# dbt Docker Environment Setup

This repository contains a containerized dbt setup using Docker Compose and Make.

## Prerequisites (Windows Users)

If you are using Windows, you will need to set up WSL (Windows Subsystem for Linux), Docker Desktop, and a utility like `make` to run the workflow commands.

**1. Install WSL and Docker**
Ensure you have initialized the Windows Subsystem for Linux:.
Open PowerShell as an Administrator and run:
```powershell
wsl --install
```
**After installing, restart your computer and  download and install [Docker](https://www.docker.com/) Desktop, ensuring the WSL2 backend is enabled in Docker's settings.**

**2. Install Scoop and Make**
If you do not have `make` installed, you can easily install it using the [Scoop](https://scoop.sh/) package manager. Open PowerShell and run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
Once Scoop is installed, install `make`:
```powershell
scoop install make
```

---

## Configuration and Credentials

Before starting the container, you must configure your environment variables so Docker and dbt can connect to your database. 

This project uses a `.env` file to securely manage credentials. 

**1. Create your `.env` file**
Copy the provided `.env_example` file and rename the copy to `.env`.

**2. Fill in the placeholders**
Open your new `.env` file and replace the `#PLACEHOLDER#` values with your actual database credentials. 

* `PORT` = The port for your database (Use `5432` as the standard for PostgreSQL)
* `POSTGRES_USER` = Your database username
* `POSTGRES_PASSWORD` = Your database password
* `POSTGRES_DB` = The name of your database
* `DOCKER_SERVICE_1` = The name of your Docker service 

*Note: Never commit your `.env` file to version control. It should be added to your `.gitignore`.*

---

## Managing the Container

We use `make` commands to simplify interactions with Docker Compose. 

### Start the Environment
To initialize and start the dbt container in the background, run:
```bash
make up
```
*(Standard command: `docker compose up -d`)*

### Stop the Environment
To stop the container, clean up dbt artifacts, and remove volumes, run:
```bash
make down
```
*(Standard command: `docker compose down -v`)*

---

## Running dbt Commands

Once your container is running (`make up`), you can interact with dbt using the following commands:

### Open an Interactive Shell
To open an interactive shell directly inside the running Python/dbt container:
```bash
make shell
```

### Generate and Serve Documentation
To generate your dbt documentation and serve it locally on port 8080:
```bash
make docs
make serve
```
*Note: The server runs in the background. You can view your docs by opening `http://localhost:8080` in your browser.*

### The Ultimate Dev Command
To compile your project, generate docs, serve them, and jump right into a container shell all in one step, simply run:
```bash
make dev
```