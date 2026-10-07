#!/bin/bash
# Crea un proyecto HyperFrames con GSAP servido en local (el proxy del entorno
# cloud bloquea cdn.jsdelivr.net, unpkg y cdnjs; solo el registro npm es accesible).
# Uso: scripts/new-video.sh <nombre> [--resolution portrait|landscape|square]
set -euo pipefail

HF="hyperframes@0.8.140"
GSAP_VERSION="3.14.2"
name="${1:?Uso: $0 <nombre> [opciones de hyperframes init]}"
shift

cd "$(dirname "$0")/.."
HYPERFRAMES_SKIP_SKILLS=1 npx -y "$HF" init "$name" --non-interactive "$@"

mkdir -p "$name/vendor"
tmp=$(mktemp -d)
(cd "$tmp" && npm pack "gsap@$GSAP_VERSION" --silent >/dev/null && tar xzf "gsap-$GSAP_VERSION.tgz")
cp "$tmp/package/dist/gsap.min.js" "$name/vendor/"
rm -rf "$tmp"

sed -i "s#https://cdn.jsdelivr.net/npm/gsap@[0-9.]*/dist/gsap.min.js#vendor/gsap.min.js#" "$name/index.html"
echo "Proyecto '$name' listo con GSAP local en $name/vendor/gsap.min.js"
