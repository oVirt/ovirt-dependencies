#!/bin/sh -e

# Directory, where build artifacts will be stored, should be passed as the 1st parameter
ARTIFACTS_DIR=${1:-exported-artifacts}

# Mark current directory as safe for git to be able to parse git hash
git config --global --add safe.directory $(pwd)

# Prepare source archive
[[ -d rpmbuild ]] || mkdir -p rpmbuild

make dist
rpmbuild \
    -D "_topdir rpmbuild" \
    -ts ovirt-dependencies-*.tar.gz
