# maps

Public map data for [Cockpit](https://github.com/byLenny/Cockpit), a vehicle launcher. The app downloads these files
at first start, which is why this repository must stay public: the app does not log in.

## Contents

| Path | What it is |
| --- | --- |
| [`basemap/`](basemap/README.md) | The world basemap: how it is built and published |
| [`.github/workflows/basemap.yml`](.github/workflows/basemap.yml) | Builds the basemap and publishes it to the `basemap` release |
| [`NOTICE.md`](NOTICE.md) | Data sources, licences and attribution |

## Published files

| File | Release | Download |
| --- | --- | --- |
| `world-basemap.mbtiles` | `basemap` | https://github.com/byLenny/maps/releases/download/basemap/world-basemap.mbtiles |

Releases are not "latest", so a download link always names its release explicitly.

## Adding a map

Add a folder for it, with a README that gives its layers, zoom range, size and data source, a build script, and a
workflow that publishes its file to its own release. Add its attribution to `NOTICE.md`.
