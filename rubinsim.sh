#!/bin/bash
now=`date +%Y-%m-%d-at-%H:%M:%S`
echo "# rubinsim addition on ${now} adding commands to set up the conda environment"
echo 'export PATH="/opt/conda/envs/rubinsim/bin:$PATH"'
echo 'export CONDA_DEFAULT_ENV="rubinsim"'
echo 'conda activate rubinsim'
echo '## Finished adapting environment rubinsim'
