FROM node:22-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install Pi globally
RUN npm install -g @earendil-works/pi-coding-agent

# Create a non-root user matching typical host user mapping
RUN useradd -ms /bin/bash piuser
USER piuser
WORKDIR /workspace

CMD ["pi"]
