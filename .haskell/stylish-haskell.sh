#!/bin/sh
# Ported from https://raw.githubusercontent.com/ndmitchell/neil/master/misc/travis.sh

set -e

PACKAGE=stylish-haskell
REPOSITORY=jaspervdj/$PACKAGE
PLATFORM=linux-x86_64

if [[ -z "${VERSION}" ]]; then
  echo "VERSION must be provided as ENV var."
  exit 1
fi

echo Downloading and running $PACKAGE...

URL=https://github.com/$REPOSITORY/releases/download/$VERSION/$PACKAGE-$VERSION-$PLATFORM.tar.gz
TEMP=$(mktemp --directory .$PACKAGE-XXXXX)

cleanup(){
    rm -r $TEMP
}
trap cleanup EXIT

echo $URL

curl --progress-bar --location -o$TEMP/$PACKAGE.tar.gz $URL
tar -xzf $TEMP/$PACKAGE.tar.gz -C$TEMP
$TEMP/$PACKAGE-$VERSION-$PLATFORM/$PACKAGE $*
