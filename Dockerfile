# =============================================
# 🧬 Lightweight Container for Metabo-Immune-Niches
# Based on micromamba (R + Python)
# =============================================
FROM mambaorg/micromamba:1.5.8 AS base

# Environment name and location
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ARG ENV_NAME=metabo-immune-niches

# Copy environment definition
COPY environment/conda.environment.yml /tmp/conda.environment.yml

# Create environment (prebuilt binaries only to avoid slow solving)
RUN micromamba create -y -n $ENV_NAME -f /tmp/conda.environment.yml \
    --channel conda-forge --channel bioconda --channel defaults --strict-channel-priority && \
    micromamba clean -a -y

# Activate automatically on shell startup
SHELL ["bash", "-c"]
ENV PATH /opt/conda/envs/$ENV_NAME/bin:$PATH
RUN echo "micromamba activate $ENV_NAME" >> ~/.bashrc

# Default command
CMD ["bash"]
