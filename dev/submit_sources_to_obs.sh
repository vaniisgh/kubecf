#!/bin/bash

# This script should be run against the directory created the the collect_sources.sh
# script. It will iterate over the directories in $1 and will create one "fake"
# rpm per directory in the OBS project defined by $2.
# The goal is to enable legaldb scan on the OBS project.

# You can use this command to run the script from within a container:
# docker run -it -e OBS_USERNAME=${OBS_USERNAME} -e OBS_PASSWORD=${OBS_PASSWORD} -v ${PWD}:/src splatform/binary_builder_obs_opensuse /bin/bash

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export CURRENT_SCRIPT=`basename "$0"`

print_help() {
  echo
  echo "# Call this script like:"
  echo "# ./submit_sources_to_obs.sh sourcesDir/ myObsProject"
}

function setup_oscrc() {

    echo "Setting up oscrc"
    sed -i "s|<username>|${OBS_USERNAME}|g" /root/.oscrc
    sed -i "s|<password>|${OBS_PASSWORD}|g" /root/.oscrc

}

function package_exists_in_obs() {

    local package=$1
    local prj=$2

    if osc search --package ${package} | grep -q $prj;
    then
        return 0
    fi

    return 1

}

function checkout_package_in_obs() {

    local package=$1
    local prj=$2

    osc checkout ${prj}/${package} -o obs-${package}
}

function create_package_in_obs() {

    local package=$1
    local prj=$2
cat << EOF > metadata
<package project="${prj}" name="${package}">
  <title>${package}</title>
  <description>
    Automatic source submit of ${package} for the use in buildpacks in SCF.
  </description>
</package>
EOF
    osc meta pkg $prj $package -F metadata
    rm -rf metadata
    checkout_package_in_obs $package $prj || true
}

function commit_package_in_obs() {

    local package=$1

    pushd obs-${package}
        osc addremove
        osc commit -m "Commiting files"
    popd
}

function delete_package_in_obs() {

    local package=$1
    local prj=$2

    osc rdelete -m 'deleting' ${prj} ${package}

}

function reset_package_in_obs() {

    local package=$1
    local prj=$2

    checkout_package_in_obs $package $prj || true

    pushd obs-${package}
        rm -rfv *
    popd

    commit_package_in_obs $package
}

if [[ ${FUNCNAME[0]} == "main" ]]; then

  set -e

  TMPDIR="$(mktemp -d -t obs.packages.XXXXXXXXXXXXXXXXX)"
  function cleanup {
    rm -rf "${TMPDIR}"
    echo "Deleted temp working directory ${TMPDIR}"
  }
  trap cleanup EXIT

  if [ -z ${1} ] || [ ! -d ${1} ]; then
    echo "No directory specified or directory doesn't exist!"
    print_help
    exit 1
  fi
  SOURCE_DIR=$(readlink -f ${1})

  OBS_PROJECT="${2}"
  if [ -z ${OBS_PROJECT} ]; then
    echo "No obs project specified!"
    print_help
    exit 1
  fi

  if [ ! $(command -v osc) ]; then
  echo "osc command not available!" && exit 1
  fi

  if [ -z ${OBS_USERNAME} ] || [ -z ${OBS_PASSWORD} ]; then
    echo "OBS_USERNAME or OBS_PASSWORD environment variable is not defined!"
    exit 1
  fi

  setup_oscrc

  pushd ${SOURCE_DIR}
  for d in $(ls -d *); do
    pushd ${TMPDIR}
    echo "Creating OBS package for ${d}"

    if package_exists_in_obs $d $OBS_PROJECT; then
      if [ -n "${OBS_FORCE_RESET}" ]; then
        echo "Deleting package ${d} from ${OBS_PROJECT} because you used the OBS_FORCE_RESET env var"
        delete_package_in_obs $d $OBS_PROJECT
      else
        echo "$d already exists in OBS, skipping."
        exit 0
      fi
    fi
    create_package_in_obs $d $OBS_PROJECT
    tar cvfz obs-${d}/sources.tgz ${SOURCE_DIR}/${d}/*
    commit_package_in_obs ${d}
    popd
  done
  popd

fi
