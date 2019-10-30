#!/usr/bin/env bash

set -o errexit -o nounset

touch "{OUTPUT}"

while read line; do
  env="${line% *}"
  val="${line#* }"
  echo "export ${env}=${val}" >> "{OUTPUT}"
done < "{INFO_FILE}"

while read line; do
  env="${line% *}"
  val="${line#* }"
  echo "export ${env}=${val}" >> "{OUTPUT}"
done < "{VERSION_FILE}"
