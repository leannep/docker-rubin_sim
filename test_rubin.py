# Simple  script to test that the rubinenv is setup and requirements were installed
import os
import unittest
import healpy as hp
import george

if __name__ == '__main__':
    print("Check rubinsim environment setup ...")
    print("CONDA_DEFAULT_ENV:", os.environ['CONDA_DEFAULT_ENV'])
    print("CONDA_PREFIX:", os.environ['CONDA_PREFIX'])
    print("rubinsim environment is setup")

    print("Check requirements are installed:")
    print("george version", george.__version__)
    print("healpy version", hp.__version__)
