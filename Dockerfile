# syntax=docker/dockerfile:1
# Multi-stage build for transformer-explainer
# Requires: Node >= 20, npm >= 10

# ── Stage 1: Build ──
FROM node:20-slim AS builder

WORKDIR /app

# Install curl (needed to download tokenizer)
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files first (better layer caching)
COPY package.json package-lock.json ./

# Clean install exact versions from lockfile
RUN npm ci

# Copy source code and static assets (including model-v2 ONNX chunks)
COPY . .

# Download GPT-2 tokenizer files locally (required — avoids CORS issues with HuggingFace)
RUN bash scripts/download-tokenizer.sh

# Build static site for root path (BASE_PATH='' overrides GitHub Pages subpath)
ENV BASE_PATH=''
ENV NODE_ENV=production
RUN npm run build

# ── Stage 2: Serve ──
FROM nginx:alpine-slim

# Copy built static assets to nginx web root
COPY --from=builder /app/build /usr/share/nginx/html

# Provide a simple nginx config for SPA/static fallback
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    gzip on; \
    gzip_types text/css application/javascript application/json image/svg+xml; \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
