FROM ghcr.io/dbt-labs/dbt-postgres:latest

# 1. Install system dependencies
RUN apt-get update && \
    apt-get install -y bash git make && \
    rm -rf /var/lib/apt/lists/*

# 2. Set an initial working directory for setup
WORKDIR /setup

# 3. Copy only the requirements file first (this caches the pip install step!)
COPY requirements.txt .

# 4. Install the Python packages from the file
RUN pip install --no-cache-dir -r requirements.txt

# 5. Switch to your actual project directory
WORKDIR /usr/app/dbt_showroom
    
ENTRYPOINT ["tail", "-f", "/dev/null"]