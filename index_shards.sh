#!/bin/bash

git config --global user.email 'pelson.pub+conda-forge@gmail.com'
git config --global user.name 'conda-forge-admin'
git config --global pull.rebase false

pushd ..
git clone --depth=1 https://github.com/conda-forge/repodata-tools.git
pushd repodata-tools
pip install -e .
popd
popd

pushd ${GITHUB_WORKSPACE}

repo_url=https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git remote set-url --push origin ${repo_url}

export UPLOAD_SLEEP_FACTOR="0.25"
sync-anaconda-data --rank=${RANK} --n-ranks=4 --time-limit=6300

popd
