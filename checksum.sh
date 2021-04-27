#!/bin/sh

. ./common.sh

checkSha1Sum() {
  local mvn_group_artifact=$(echo "${url}" | sed -r 's/(^.*filepath=)(.*)\2//g' )
  local mvn_artifact_file="${DEPENDENCIES}/${mvn_group_artifact}"

  common_check_sha1sum "${mvn_artifact_file}" "${sha1sum}" ||
    die "Invalid sha1sum for ${mvn_artifact_file}: $(common_calc_sha1sum "${mvn_artifact_file}"), expected: ${sha1sum}"
}

DEPENDENCIES="$1"

common_iterate common_void checkSha1Sum
