#!/bin/sh
# Configure Build & Run
set -e

mkdir -p "$JCODE_PROJECT_DIR/.jcode"
cat > "$JCODE_PROJECT_DIR/.jcode/run.yaml" <<YAML
version: 1
name: Next.js (dev)
readyPort: 3000
terminals:
  - label: Web
    command: |
      clear
      set -e
      SRC="$JCODE_PROJECT_DIR"
      STAGE="\$HOME/.jcode-run/$JCODE_PROJECT_NAME-web"
      echo '== J Code: Next.js dev server =='
      rm -rf "\$STAGE" && mkdir -p "\$STAGE" && cp -a "\$SRC/." "\$STAGE/"
      cd "\$STAGE"
      npm install
      npm run dev -- -H 0.0.0.0 -p 3000
YAML
