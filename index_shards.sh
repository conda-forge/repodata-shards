#!/bin/bash

pushd ${GITHUB_WORKSPACE}

repo_url=https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git remote set-url --push origin ${repo_url}

export UPLOAD_SLEEP_FACTOR="0.25"
sync-anaconda-data --step=${SYNC_STEP} --rank=${RANK} --n-ranks=4 --time-limit=2700

popd
