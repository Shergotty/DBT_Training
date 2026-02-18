FROM ghcr.io/dbt-labs/dbt-postgres:latest

WORKDIR /usr/app/dbt_showroom

# Install bash, git, and MAKE
RUN apt-get update && \
    apt-get install -y bash git make && \
    rm -rf /var/lib/apt/lists/*
    
ENTRYPOINT ["tail", "-f", "/dev/null"]
