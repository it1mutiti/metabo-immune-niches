FROM mambaorg/micromamba:1.5.8

LABEL maintainer="it1mutiti <it1mutiti@users.noreply.github.com>"
LABEL org.opencontainers.image.source="https://github.com/it1mutiti/metabo-immune-niches"

USER root
RUN apt-get update -qq && \
    apt-get install -y git git-lfs && \
    git lfs install && \
    rm -rf /var/lib/apt/lists/*

COPY environment/conda.environment.yml /tmp/conda.environment.yml

# Build environment (YAML enforces strict channels)
RUN micromamba create -y -n metabo-immune-niches -f /tmp/conda.environment.yml && \
    micromamba clean -a -y

ENV MAMBA_DOCKERFILE_ACTIVATE=1
SHELL ["/bin/bash", "-lc"]
ENV PATH=/opt/conda/envs/metabo-immune-niches/bin:$PATH
ENV CONDA_DEFAULT_ENV=metabo-immune-niches

RUN python -c "import anndata, scanpy, squidpy; print('✅', anndata.__version__, scanpy.__version__, squidpy.__version__)"

WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh"]
CMD ["/bin/bash"]
