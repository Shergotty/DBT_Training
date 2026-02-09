#!/bin/bash

# Load environment variables from .env if it exists
if [ -f .env ]; then
    # Use sed to strip Windows carriage returns (\r) before sourcing
    set -a; source <(sed 's/\r$//' .env); set +a
else
    echo "Debug: .env file not found in $(pwd)"
fi


docker compose exec "$PYTHON_SERVICE" bash
