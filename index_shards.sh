#!/bin/bash

conda install -y -q git

git config --global user.email '64793534+conda-forge-daemon@users.noreply.github.com'
git config --global user.name 'conda-forge-daemon'
git config --global pull.rebase false

pushd ..

git clone --depth=1 https://github.com/conda-forge/repodata-tools.git
pushd repodata-tools
conda install -y -q --file requirements.txt
pip install -e .
popd

popd

pushd ${GITHUB_WORKSPACE}

repo_url=https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git remote set-url --push origin ${repo_url}

export UPLOAD_SLEEP_FACTOR="1.25"
sync-anaconda-data --rank=${RANK} --n-ranks=4

popd
