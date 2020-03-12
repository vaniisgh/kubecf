#!/bin/bash
# This script gather sources from a group of bosh releases that are consumed 
# in kubecf.
# It takes a file as input which should be a list of images and for each
# one of them it creates a directory with the sources of that bosh release.

# Those can be used then to create packages in OBS and submit to legal scan with
# some other script.
# Example imagelist.txt :
# [
#   "k8s.gcr.io/kube-apiserver:v1.13.4",
#   "k8s.gcr.io/kube-controller-manager:v1.13.4",
#   "k8s.gcr.io/kube-scheduler:v1.13.4",
#   "k8s.gcr.io/kube-proxy:v1.13.4",
#   "weaveworks/weave-npc:2.5.1",
#   "weaveworks/weave-kube:2.5.1",
#   "k8s.gcr.io/coredns:1.2.6",
#   "k8s.gcr.io/etcd:3.2.24",
#   "k8s.gcr.io/pause:3.1"
# ]
# 
# Call it with <0> imagelist.txt output/

set -e
IMAGE_LIST="${1}"
FINAL_SOURCES_DIR="${2}"
DEFAULT_BUCKET_URL="${3:-https://s3.amazonaws.com/suse-final-releases/}"
STEMCELL="${STEMCELL:-splatform/fissile-stemcell-sle:SLE_15_SP1-23.11}"
# This variable is a json map which contains only the images we care about 
# (derived from bosh releases that have been processed by fissile)
# Every entry contains all the required fields to also run the fissile compilation 

WHITELIST=$(cat <<'EOF'
{
   "suse-ruby-buildpack": {
    "url": "https://github.com/SUSE/cf-ruby-buildpack-release",
    "release_name": "ruby-buildpack-release"
  },                                                                                                                                                          
    "suse-python-buildpack": {
    "release_name": "python-buildpack-release",
    "url": "https://github.com/SUSE/cf-python-buildpack-release"
  }
}
EOF
)

if [ ! -f ${IMAGE_LIST} ]; then
  echo "File ${IMAGE_LIST} doesn't exist!"
	exit 1
fi

WORK_TMP="$(mktemp -d -t sources.fissile.XXXXXXXXXXXXXXXXX)"

# deletes the temp directory
function cleanup {      
  rm -rf "$WORK_TMP"
  echo "Deleted temp working directory $WORK_TMP"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

mkdir -p ${FINAL_SOURCES_DIR}

fissile_build() {
	local stemcell="$1"
	local name="$2"
	local version="$3"
	local url="$4"
	local sha="$5"
	local output_dir="$6"
	set +e
	current_img="$(docker images -f "reference=*$name:*" --format="{{.ID}}")"
	docker rmi "$current_img"
	set -e
	mkdir -p $output_dir
  docker pull "$stemcell"
	fissile build release-images \
		--stemcell="$stemcell" \
		--name="$name" \
		--version="$version" \
		--sha1="${sha}" --url="${url}" \
		-w ${output_dir}
}

get_component_tarball(){
  local COMPONENT=$1
  local VERSION=$2
	COMPONENT_RELEASE_NAME=$(echo $WHITELIST | jq -r ".[\"${COMPONENT}\"].release_name")
  COMPONENT_URL="${DEFAULT_BUCKET_URL}${COMPONENT_RELEASE_NAME}-${VERSION}.tgz"
  mkdir -p $WORK_TMP/$COMPONENT

  pushd $WORK_TMP/$COMPONENT
    wget "$COMPONENT_URL" || exit 1
  popd

}

SKIPPED=()
whitelist_regexp=$(echo $WHITELIST | jq -r 'keys | join("|")')
for row in $(cat ${IMAGE_LIST} | jq -r '.[]'); do
	if [ $(echo ${row} | grep -E "${whitelist_regexp}") ]; then
	  VERSION=$(echo ${row} | grep -oP '.*\-\K(.*)$')
    COMPONENT=$(echo ${row} | sed 's/.*\/\(.*\):.*/\1/')
		get_component_tarball "${COMPONENT}" "${VERSION}"

	  component_tarball=$(echo $(readlink -e "${WORK_TMP}/${COMPONENT}"/*))

    # https://github.com/cloudfoundry-incubator/cf-operator-ci/blob/0cf1b2120ad7499e40976702af4d133f3720eee6/pipelines/release-images/tasks/build.sh#L29
    SHA1=$(sha1sum $component_tarball | cut -f1 -d ' ' )

	  COMPONENT_RELEASE_NAME=$(echo $WHITELIST | jq -r ".[\"${COMPONENT}\"].release_name")
		echo
		echo "== Collecting sources for: ${COMPONENT}@${VERSION} sources at ${COMPONENT_URL} =="
	  echo
		COMPONENT_SOURCE_DIR="${FINAL_SOURCES_DIR}/${COMPONENT}-${VERSION}"
		fissile_output_dir="${COMPONENT_SOURCE_DIR}/fissile"
		git_checkout_dir="${COMPONENT_SOURCE_DIR}/release_src"
		mkdir -p "${fissile_output_dir}"
		mkdir -p "${git_checkout_dir}"

  	fissile_build "${STEMCELL}" \
			"python-buildpack" \
			"${VERSION}" \
			"file://${component_tarball}" \
			"${SHA1}" \
			"${fissile_output_dir}"

		COMPONENT_REMOTE_URL=$(echo $WHITELIST | jq -r ".[\"${COMPONENT}\"].url")
		git clone --recurse-submodules --branch "${VERSION}" --depth 1 "${COMPONENT_REMOTE_URL}" "${git_checkout_dir}"

  else
		SKIPPED+=( "${row}" )
	fi
done

echo
echo "== Skipped content by defined WHITELIST policy =="
echo

printf '%s\n' "${SKIPPED[@]}"
echo
