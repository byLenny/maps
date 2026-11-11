# Basemap

A rough map of the whole planet for the Cockpit app to download at first start, so the map is never empty before a
detailed map is installed.

| | |
| --- | --- |
| File | `world-basemap.mbtiles` (vector tiles, MBTiles) |
| Zoom | 0 to 5 |
| Size | about 2.7 MB |
| Layers | `ocean`, `land`, `lakes`, `boundaries` |
| Data | [Natural Earth](https://www.naturalearthdata.com/), public domain (see [NOTICE.md](../NOTICE.md)) |
| Builder | [tippecanoe](https://github.com/felt/tippecanoe) |

Download the current build:

```
https://github.com/byLenny/maps/releases/download/basemap/world-basemap.mbtiles
```

## Build it

Needs `curl` and `tippecanoe` on the PATH:

```sh
basemap/build.sh            # writes basemap/output/world-basemap.mbtiles
```

## Publish it

The `Basemap` workflow (`.github/workflows/basemap.yml`) does three things:

1. Builds the file and checks that the four layers exist.
2. Publishes it to the `basemap` release of this repository, as the asset `world-basemap.mbtiles`. The release is
   marked "not latest", so it never replaces a release of the Cockpit app.
3. Deploys the map page in `site/` to GitHub Pages, with the tiles from the file unpacked by `export-pages.py`.

It runs on a push to `main` that changes `basemap/`, `site/` or the workflow, and when started by hand from the
Actions tab. Pages deploys only from `main`. The tiles are built in the workflow and never committed.

`export-pages.py` turns the MBTiles file into `tiles/<z>/<x>/<y>.pbf`, flips the row order to the XYZ order the map
uses, and gunzips the tiles, because Pages does not send a `Content-Encoding` header.
