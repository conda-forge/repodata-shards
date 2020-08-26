#!/bin/bash

conda install -y -q git

git config --global user.email 'dummy-email@dummy-email.org'
git config --global user.name 'conda-forge-daemon'
git config --global pull.rebase true

pushd ..

git clone --depth=1 https://github.com/regro/repodata-tools.git
pushd repodata-tools
conda install -y -q --file requirements.txt
pip install -e .
popd

git clone https://github.com/regro/releases.git
releases_repo_path=`pwd`/releases
pushd releases
repo_url=https://${GITHUB_TOKEN}@github.com/regro/releases.git
git remote set-url --push origin ${repo_url}
popd

popd

pushd ${GITHUB_WORKSPACE}

repo_url=https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git remote set-url --push origin ${repo_url}

sync-anaconda-data --rank=${RANK} --n-ranks=4 --releases-repo-path=${releases_repo_path}

popd
