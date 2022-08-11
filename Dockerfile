ARG BASE_CONTAINER=jupyter/pyspark-notebook@sha256:62c378bc13618899aa0628401e00503dc139b1367028e3e9effdbca0749b6c1c
FROM $BASE_CONTAINER

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Tensorflow
# From: https://github.com/jupyter/docker-stacks/blob/main/tensorflow-notebook/Dockerfile
RUN mamba install --quiet --yes \
    'tensorflow' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
