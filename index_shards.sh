#!/bin/bash

conda install -y -q git

git config --global user.email 'conda.forge.daemon@gmail.com'
git config --global user.name 'conda-forge-daemon'
git config --global pull.rebase false

pushd ..
git clone --depth=1 https://github.com/regro/repodata-tools.git
rt_pth=`pwd`/repodata-tools
popd

conda install -y -q --file ${rt_pth}/requirements.txt

pushd ${GITHUB_WORKSPACE}

repo_url=https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git remote set-url --push origin ${repo_url}

python ${rt_pth}/scripts/make_anaconda_shards.py ${RANK}

popd
