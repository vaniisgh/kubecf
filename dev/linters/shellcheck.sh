#!/usr/bin/env bash

set -o errexit -o nounset

workspace=$(dirname "$(realpath '{root_file}')")

# shellcheck disable=SC2046
# We want word splitting with find.
"{shellcheck}" -- $(find "${workspace}" -name '*.sh')
