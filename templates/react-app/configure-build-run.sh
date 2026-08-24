#!/bin/sh
# Configure Build & Run
set -e

mkdir -p "$JCODE_PROJECT_DIR/.jcode"
cat > "$JCODE_PROJECT_DIR/.jcode/run.yaml" <<YAML
version: 1
name: Vite / React dev server
readyPort: 5173
terminals:
  - label: Client
    command: |
      clear
      set -e
      CLIENT="$JCODE_PROJECT_DIR"
      STAGE="\$HOME/.jcode-run/$JCODE_PROJECT_NAME-client"
      echo '== J Code: Client (Vite dev server) =='
      export npm_config_fund=false npm_config_audit=false
      echo '[1/2] Staging client + installing deps (npm install)...'
      rm -rf "\$STAGE" && mkdir -p "\$STAGE" && cp -a "\$CLIENT/." "\$STAGE/"
      cd "\$STAGE"
      npm install
      echo '[2/2] Starting Vite dev server on http://localhost:5173 ...'
      npm run dev -- --host 0.0.0.0 --port 5173
YAML
