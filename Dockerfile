FROM n8nio/n8n:latest

# Debug message
RUN echo "Starting to build Dockerfile..."

# Install ffmpeg
USER root
RUN echo "Updating apt-get and installing ffmpeg..." && \
    apt-get update && \
    apt-get install -y ffmpeg && \
    echo "ffmpeg installed successfully."

# Switch back to n8n user
USER node

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

# Debug message
RUN echo "Setting Postgres environment variables..."
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD
RUN echo "Postgres environment variables set."

ARG ENCRYPTION_KEY

# Debug message
RUN echo "Setting encryption key..."
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY
RUN echo "Encryption key set."

# Debug message
RUN echo "Finished building Dockerfile."

CMD ["n8n", "start"]