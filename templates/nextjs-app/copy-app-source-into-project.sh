#!/bin/sh
# Copy app source into project
set -e

set -eu
cd "$JCODE_STAGING_DIR/app"
tar --exclude=node_modules --exclude=.next -cf - . | (cd "$JCODE_PROJECT_DIR" && tar -xf -)
# A pipeline reports only its LAST command's status, so a producer that dies half-way still
# looks like success and hands back a half-copied project. Steps run under dash, which has no
# `pipefail`, so check the one file whose absence makes the result unusable: without a manifest
# neither `npm install` nor `npm run dev` can run, and the generated run config cannot work.
test -f "$JCODE_PROJECT_DIR/package.json" || {
  echo "Copy incomplete: package.json did not reach $JCODE_PROJECT_DIR." >&2
  exit 1
}
