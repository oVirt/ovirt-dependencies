#!/bin/sh -e

# Directory, where build artifacts will be stored, should be passed as the 1st parameter
ARTIFACTS_DIR=${1:-exported-artifacts}

# Prepare source archive
[[ -d rpmbuild ]] || mkdir -p rpmbuild

make dist
rpmbuild \
    -D "_topdir rpmbuild" \
    -ts ovirt-dependencies-*.tar.gz
