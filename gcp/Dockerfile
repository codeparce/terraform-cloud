# Instalar Vault CLI
FROM hashicorp/vault:latest AS vault

# Instalar Google Cloud SDK
FROM google/cloud-sdk:latest AS gcp

# Instalar Terraform CLI
FROM hashicorp/terraform:latest AS tf

# Imagen final Ubuntu limpia
FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias básicas 
# docker.io \
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    jq \
    gettext-base \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copiar binario de Vault
COPY --from=vault /bin/vault /usr/local/bin/vault

# Copiar binario de Terraform 
COPY --from=tf /bin/terraform /usr/local/bin/terraform

# Copiar Google Cloud SDK completo
COPY --from=gcp /usr/lib/google-cloud-sdk /usr/lib/google-cloud-sdk

# Añadir gcloud al PATH
ENV PATH="/usr/lib/google-cloud-sdk/bin:${PATH}"

# Verificación
# RUN vault --version && \
#     gcloud --version && \
#     jq --version && \
#     git --version && \
#     terraform --version

WORKDIR /workspace

CMD ["/bin/bash"]

