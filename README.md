# repodata-shards

This repo holds repodata shards for conda-forge.

## Current Issues

1. We are not pulling the data from labels besides `main`.
2. We are pulling the patched repodata, but we should be pulling the raw 
   repodata.
3. We are not pushing to this repo when a package is uploaded to github.
