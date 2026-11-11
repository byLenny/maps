#!/usr/bin/env bash
# Builds world-basemap.mbtiles: a rough, low-zoom (0-5) map of the whole planet from Natural Earth (public domain).
# See ../basemap/README.md and ../NOTICE.md.
#
#   basemap/build.sh [output-dir]      # default: basemap/output
#
# Needs curl and tippecanoe (https://github.com/felt/tippecanoe) on the PATH.
#
# Layers (polygon layers carry no attributes; Cockpit's style only needs shapes):
#   ocean       the sea
#   land        the land
#   lakes       the big lakes
#   boundaries  country borders on land
# These are not OpenMapTiles layers, so the Cockpit map style has to draw them by these names.
set -euo pipefail

OUT_DIR="${1:-$(cd "$(dirname "$0")" && pwd)/output}"
BASE_URL="https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson"
LAYERS=(ne_50m_ocean ne_50m_land ne_50m_lakes ne_50m_admin_0_boundary_lines_land)

mkdir -p "$OUT_DIR"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

for name in "${LAYERS[@]}"; do
  echo "Downloading $name"
  curl -fsSL --retry 3 -o "$WORK/$name.geojson" "$BASE_URL/$name.geojson"
done

# --drop-densest-as-needed keeps the busy low-zoom tiles under tippecanoe's tile size limit by dropping the smallest features.
tippecanoe \
  --force \
  --output "$OUT_DIR/world-basemap.mbtiles" \
  --minimum-zoom 0 --maximum-zoom 5 \
  --drop-densest-as-needed \
  --name "Cockpit world basemap" \
  --description "Rough world map, zoom 0-5, from Natural Earth (public domain)" \
  --attribution "Natural Earth" \
  -L "ocean:$WORK/ne_50m_ocean.geojson" \
  -L "land:$WORK/ne_50m_land.geojson" \
  -L "lakes:$WORK/ne_50m_lakes.geojson" \
  -L "boundaries:$WORK/ne_50m_admin_0_boundary_lines_land.geojson"

ls -l "$OUT_DIR/world-basemap.mbtiles"
