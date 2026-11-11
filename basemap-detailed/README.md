# Detailed world map

The same world as [`basemap/`](../basemap/README.md), with roads and populated places, from
[Natural Earth](https://www.naturalearthdata.com/) 10m data (public domain, see [NOTICE.md](../NOTICE.md)).

| | |
| --- | --- |
| File | `world-detailed.pmtiles` (PMTiles v3, vector tiles) |
| Zoom | 0 to 8 |
| Layers | `ocean`, `land`, `lakes`, `boundaries` (as in the basic map), `roads`, `places` |
| Builder | [tippecanoe](https://github.com/felt/tippecanoe), then `pmtiles convert` |

Download the current build:

```
https://github.com/byLenny/maps/releases/download/basemap/world-detailed.pmtiles
```

## Build it

```sh
basemap-detailed/build.sh     # writes basemap-detailed/output/world-detailed.pmtiles
```

The `Detailed basemap` workflow builds it on a push to `main` that changes this folder or its workflow, and when
started by hand. It publishes the file to the `basemap` release, next to the basic map, and checks the layers first.
