#!/usr/bin/env sh

set -e

path="$1"
if [ -z "$path" ]; then
    echo "Please pass a path" >&2
    exit 1
fi
shift

bin_folder="`dirname "$(realpath "$0")"`"
root_folder="$bin_folder/.."

name="`basename "$(realpath "$root_folder")"`"
host="${FLUX_PUBLISH_DOCKER_HOST:=}"
host_with_slash="${host}${host:+/}"
user="${FLUX_PUBLISH_DOCKER_USER:=fluxfw}"
image="$host_with_slash$user/$name"
tag="v`echo -n "$(cat "$root_folder/version")"`"

path_host="`realpath "$path"`"
path_volume="/host/`basename "$path_host"`"

docker run --rm -it --network none -u "`id -u`":"`id -g`" -v "$path_host":"$path_volume":ro "$image:$tag" "$path_volume" "$@"
