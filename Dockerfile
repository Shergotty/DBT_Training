FROM ghcr.io/dbt-labs/dbt-postgres:latest

WORKDIR /usr/app/dbt_showroom

# Install bash and git (useful for dbt deps)
RUN apt-get update && \
    apt-get install -y bash git
    

ENTRYPOINT ["tail", "-f", "/dev/null"]
