# --- STAGE 1: Build ---
FROM python:3.12-slim AS builder
WORKDIR /app

# Install system dependencies needed to compile flask_mysqldb
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN pip install --user --no-cache-dir -r requirement.txt

# --- STAGE 2: Run ---
FROM python:3.12-slim
WORKDIR /app

# Install ONLY the runtime library for MySQL (needed for the app to run)
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.local /root/.local
COPY . .

ENV PATH=/root/.local/bin:$PATH
EXPOSE 5000

CMD ["python", "app.py"]