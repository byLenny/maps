#!/usr/bin/env python3
"""Unpacks an .mbtiles vector file into the static tree that GitHub Pages serves.

    basemap/export-pages.py <file.mbtiles> <site-dir>

Writes <site-dir>/tiles/<z>/<x>/<y>.pbf. The row is flipped from MBTiles (TMS) to the XYZ order the map uses, and tiles
stored compressed are gunzipped, because Pages does not send a Content-Encoding header. The tiles folder is replaced on
each run, so tiles that left the source do not linger.
"""
import gzip
import pathlib
import shutil
import sqlite3
import sys


def main(source: str, site: str) -> int:
    tiles_dir = pathlib.Path(site) / "tiles"
    if tiles_dir.exists():
        shutil.rmtree(tiles_dir)
    count = 0
    with sqlite3.connect(f"file:{source}?mode=ro", uri=True) as db:
        rows = db.execute("SELECT zoom_level, tile_column, tile_row, tile_data FROM tiles")
        for zoom, column, row, data in rows:
            if data[:2] == b"\x1f\x8b":
                data = gzip.decompress(data)
            y = (1 << zoom) - 1 - row
            folder = tiles_dir / str(zoom) / str(column)
            folder.mkdir(parents=True, exist_ok=True)
            (folder / f"{y}.pbf").write_bytes(data)
            count += 1
    print(f"Wrote {count} tiles to {tiles_dir}")
    return 0 if count > 0 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1], sys.argv[2]))
