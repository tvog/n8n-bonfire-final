FROM n8nio/n8n:latest

# Debug message
RUN echo "Starting to build Dockerfile..."

# Install ffmpeg
USER root
RUN echo "Updating apt-get and installing ffmpeg..." && \
    apt-get update && \
    apt-get install -y ffmpeg

# Debug message
RUN echo "ffmpeg installed successfully."

# Switch back to n8n user
USER node

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

# Debug message
RUN echo "Postgres environment variables set."

ARG ENCRYPTION_KEY

ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

# Debug message
RUN echo "Encryption key set."

CMD ["n8n", "start"]
