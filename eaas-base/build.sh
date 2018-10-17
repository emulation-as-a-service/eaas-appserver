#!/bin/bash
set -e
branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
git rev-parse HEAD > GIT_VERSION
docker build -t "eaas/eaas-base-$branch" .
