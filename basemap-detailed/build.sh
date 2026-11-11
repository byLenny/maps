#!/usr/bin/env bash
# Builds world-detailed.pmtiles: a world map from Natural Earth 10m data (public domain), zoom 0-8, with roads and
# populated places as well as the land, sea, lakes and borders of the basic world map.
#
#   basemap-detailed/build.sh [output-dir]      # default: basemap-detailed/output
#
# Needs curl, tippecanoe (https://github.com/felt/tippecanoe) and the pmtiles tool (https://github.com/protomaps/go-pmtiles)
# on the PATH. The workflow installs both.
#
# Layer names are the same as the basic map's for the shared layers (ocean, land, lakes, boundaries), so the Cockpit
# map style draws either file with the same names. roads and places are new.
set -euo pipefail

OUT_DIR="${1:-$(cd "$(dirname "$0")" && pwd)/output}"
BASE_URL="https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
mkdir -p "$OUT_DIR"

fetch() {
  echo "Downloading $1"
  curl -fsSL --retry 3 -o "$WORK/$1.geojson" "$BASE_URL/$1.geojson"
}
for name in ne_10m_ocean ne_10m_land ne_10m_lakes ne_10m_admin_0_boundary_lines_land ne_10m_roads ne_10m_populated_places; do
  fetch "$name"
done

tippecanoe \
  --force \
  --output "$WORK/world-detailed.mbtiles" \
  --minimum-zoom 0 --maximum-zoom 8 \
  --drop-densest-as-needed \
  --name "Cockpit detailed world map" \
  --description "World map, zoom 0-8, from Natural Earth 10m (public domain): land, sea, lakes, borders, roads, populated places" \
  --attribution "Natural Earth" \
  -L "ocean:$WORK/ne_10m_ocean.geojson" \
  -L "land:$WORK/ne_10m_land.geojson" \
  -L "lakes:$WORK/ne_10m_lakes.geojson" \
  -L "boundaries:$WORK/ne_10m_admin_0_boundary_lines_land.geojson" \
  -L "roads:$WORK/ne_10m_roads.geojson" \
  -L "places:$WORK/ne_10m_populated_places.geojson"

pmtiles convert "$WORK/world-detailed.mbtiles" "$OUT_DIR/world-detailed.pmtiles"
ls -l "$OUT_DIR/world-detailed.pmtiles"
