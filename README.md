# maps

Public map data for [Cockpit](https://github.com/byLenny/Cockpit), the vehicle launcher. The app downloads these files
at first start, so this repository has to stay public.

## World basemap

A rough map of the whole planet (zoom 0-5: sea, land, big lakes, country borders), made from
[Natural Earth](https://www.naturalearthdata.com/), which is public domain.

Download: https://github.com/byLenny/maps/releases/download/basemap/world-basemap.mbtiles

The `World basemap` workflow builds the file and publishes it to the `basemap` release on every change to the build,
or when started by hand (Actions > World basemap > Run workflow). The release is never marked "latest".

Build it locally (needs curl and [tippecanoe](https://github.com/felt/tippecanoe)):

```sh
tools/basemap/build-world-basemap.sh      # writes tools/basemap/output/world-basemap.mbtiles
```
