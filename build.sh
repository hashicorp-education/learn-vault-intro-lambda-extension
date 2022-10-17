#!/bin/sh

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "${DIR}/demo-function"

echo "Removing old builds..."
rm -f demo-function.zip 2> /dev/null


echo

echo "Making new zip..."
zip -j -D -r demo-function.zip handler.py 

popd # ${DIR}