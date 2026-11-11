# maps

Public map data for [Cockpit](https://github.com/byLenny/Cockpit), a vehicle launcher. The app downloads these files
at first start, which is why this repository must stay public: the app does not log in.

## Contents

| Path | What it is |
| --- | --- |
| [`basemap/`](basemap/README.md) | The world basemap: its build script and the tool that turns it into web tiles |
| [`site/`](site/index.html) | The map page, published to GitHub Pages with the basemap's tiles |
| [`.github/workflows/basemap.yml`](.github/workflows/basemap.yml) | Builds the basemap, publishes its release and deploys the page |
| [`NOTICE.md`](NOTICE.md) | Data sources, licences and attribution |

## Published files

| File | Release | Download |
| --- | --- | --- |
| `world-basemap.mbtiles` | `basemap` | https://github.com/byLenny/maps/releases/download/basemap/world-basemap.mbtiles |

Releases are not "latest", so a download link always names its release explicitly.

The map page is at https://bylenny.github.io/maps/. It is deployed by the workflow, not kept in git.

## Adding a map

Add a folder under `basemap/`'s pattern for it, with a README that gives its layers, zoom range, size and data source,
and a build script. Add its job to the workflow, which publishes its file to its own release. Add its attribution to
`NOTICE.md`.
