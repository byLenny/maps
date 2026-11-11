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

The `Basemap` workflow (`.github/workflows/basemap.yml`) builds the file and publishes it to the `basemap` release of
this repository, as the asset `world-basemap.mbtiles`. It runs on a push to `main` that changes `basemap/` or the
workflow, and when started by hand from the Actions tab. The release is marked "not latest", so it never replaces a
release of the Cockpit app.

The workflow checks that the four layers exist before it publishes.
