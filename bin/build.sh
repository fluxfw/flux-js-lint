#!/usr/bin/env sh

set -e

bin_folder="`dirname "$0"`"
root_folder="$bin_folder/.."

name="`basename "$(realpath "$root_folder")"`"
host="${FLUX_PUBLISH_DOCKER_HOST:=}"
host_with_slash="${host}${host:+/}"
user="${FLUX_PUBLISH_DOCKER_USER:=fluxfw}"
image="$host_with_slash$user/$name"
tag="v`echo -n "$(cat "$root_folder/version")"`"

docker build "$root_folder" --pull -t "$image:$tag" -t "$image:latest"
