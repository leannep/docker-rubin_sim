FROM continuumio/miniconda3

ARG conda_env=rubinsim

LABEL MAINTAINER="Leanne Guy <leanne@lsst.org>"
LABEL DESCRIPTION="Docker file for rubin_sim"

WORKDIR /usr/app

COPY environment.yaml .
COPY rubinsim.sh .
COPY test_rubin.py .
COPY entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh

# Update base conda
RUN conda update -n base conda

# Create the environment (-v for verbose).
# The environment name is in the environment.yaml file
RUN conda env create -f environment.yaml
# RUN conda clean --all -f --yes

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "rubinsim", "/bin/bash", "-c"]

# Update bashrc to activate the rubinsim environment
RUN ["/bin/bash","-c", "./rubinsim.sh >>  /root/.bashrc"]

# Add environment to PATH
ENV PATH /opt/conda/envs/$conda_env/bin:$PATH
RUN /bin/bash -c "source activate $conda_env"
ENV CONDA_DEFAULT_ENV $conda_env

# The code to run when container is started. (activate the rubinsim env when connecting to the container. test_rbin will fail without this
# This is probably what makes the pycharm connection use the rubinsim env - i.e pycharm cones in via a container
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["python", "test_rubin.py"]
# ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "rubinsim", "python", "test_rubin.py"]
