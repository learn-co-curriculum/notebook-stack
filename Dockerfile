# Start with pyspark-notebook image base
ARG BASE_CONTAINER=jupyter/pyspark-notebook@sha256:62c378bc13618899aa0628401e00503dc139b1367028e3e9effdbca0749b6c1c
FROM $BASE_CONTAINER

# Adapted from: https://github.com/jupyter/docker-stacks/blob/main/tensorflow-notebook/Dockerfile
# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install conda dependencies not included in pyspark-notebook
WORKDIR /tmp
COPY spec-list.txt /tmp/spec-list.txt

RUN mamba install --quiet --yes --file spec-list.txt \
    && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

WORKDIR "${HOME}"
