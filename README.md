## OpenContourMapTiles 

OpenContourMapTiles is a small fork of [openmaptiles.org](http://openmaptiles.org/) to generate in one command line elevation contours vector tiles
thanks to [phyghtmap tool](http://katze.tfiu.de/projects/phyghtmap/).

Read the OpenMapTiles doc to get used about their toolchain, how to install, use it etc.

- :link: Docs http://openmaptiles.org/docs

## Develop

To create contours tiles you need Docker.
- Install [Docker](https://docs.docker.com/engine/installation/). Minimum version is 1.12.3+.
- Install [Docker Compose](https://docs.docker.com/compose/install/). Minimum version is 1.7.1+.

I work with OSX, I have no issues with it. Linux user will also feel good.

If you are here you already know git and have cloned this repo!

### Register

You'll need to register to https://ers.cr.usgs.gov/register/ in order to allow phyghtmap to download elevation data. It's free.

Once you have your user and login, create a file named .earthexplorerCredentials in the root directory of the repo with the content:

```
USER=your_user_name
PASSWORD=your_password
``` 

### Build

Build the tileset in one command line

First you can edit the .env file to change the zoom levels that will be created. 0-14 is the max.

Then use the quickstart script helper

```
./quickstart.sh france
```

This will generate a new elevation mbtiles set of all France area... Quite long!

Try first with a small area.

### Results

You'll end up if everything works with a file tiles.mbtiles in data directory.

This file contains all vectors tiles with contour layer over your selected area.

Contours lines step is configured to 10m. 

Ex: I ran it with "ile-de-france", the area around Paris, France.

Launch a tile server locally to test your data

```
make start-tileserver
```

and check at http://127.0.0.1:8080/ the raw result (click on inspect link on DATA section)

Result:
![alt text](https://raw.githubusercontent.com/RomainQuidet/openmaptiles/contours/ile-de-france.png "ile-de-france raw elevation contours")

Ile-de-france build took around 5 min, while French Alps area required around 40 min on my old 2013 iMac.

## TODO

Once you've got your tiles, you'll need to create a mapbox sytle to serve them from a mapbox tile server.

The content of the tiles is quite simple:

- Only line strings id "contour"

- One key "ele" for the elevation in meters

I'll try to create a nice style json to be ready to use.

## License

All code in this repository is under the [BSD license](./LICENSE.md) and the cartography decisions encoded in the schema and SQL are licensed under [CC-BY](./LICENSE.md).

For a browsable electronic map based on OpenMapTiles and OpenStreetMap data, the
credit should appear in the corner of the map. For example:

[© OpenMapTiles](http://openmaptiles.org/) [© OpenStreetMap contributors](http://www.openstreetmap.org/copyright)

For printed and static maps a similar attribution should be made in a textual
description near the image, in the same fashion as if you cite a photograph.
