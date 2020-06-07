#! /usr/bin/env python3
from setuptools import setup

setup(
    name="default_app",
    version="1.0",
    packages=["default_app"],
    package_data={"data_server": ["templates/*", "static/*"]},
    install_requires=["flask"],
)
