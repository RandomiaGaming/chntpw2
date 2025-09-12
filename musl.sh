#!/bin/env sh
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

rm -rf ./musl
echo Downloading Musl...
curl https://musl.cc/x86_64-linux-musl-native.tgz -o ./musl.tgz --progress-bar
echo Extracting Musl...
tar -xvf ./musl.tgz 1>/dev/null 2>&1
rm ./musl.tgz
mv ./x86_64-linux-musl-native ./musl