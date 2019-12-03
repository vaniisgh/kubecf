#!/usr/bin/env bash

set -o errexit

"{helm}" lint -- "{chart}"
