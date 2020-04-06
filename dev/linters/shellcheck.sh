#!/usr/bin/env bash

set -o errexit -o nounset

workspace=$(bazel info workspace)

# shellcheck disable=SC2046
# We want word splitting with find.
# Ignore all submodule files under src/.
bazel run @shellcheck//:binary -- $(find "${workspace}" -name src -prune -o -name '*.sh' -print)
