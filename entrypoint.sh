#!/bin/bash --login
set -e

# activate conda environment and let the following process take over
export PATH="/opt/conda/envs/rubinsim/bin:$PATH"
export CONDA_DEFAULT_ENV="rubinsim"
conda activate rubinsim
exec "$@"