#!/usr/bin/env sh

set -e

root="`dirname "$0"`/.."
libs="$root/.."

checkAlreadyInstalled() {
    if [ `ls "$libs" | wc -l` != "1" ]; then
        echo "Already installed"
        exit 1
    fi
}

installNodeModules() {
    (cd "$root" && npm ci --omit=dev && mv node_modules ../node_modules)
}

installLibrary() {
    (mkdir -p "$libs/$1" && cd "$libs/$1" && wget -O - "$2" | tar -xz --strip-components=1)
}

checkAlreadyInstalled

installNodeModules

installLibrary flux-shutdown-handler-api https://github.com/fluxfw/flux-shutdown-handler-api/archive/refs/tags/v2022-12-08-1.tar.gz
