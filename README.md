# docker-overpass-api
Docker Overpass API container

# Get filtered planet file

```
curl -o planet.osm.bz2 http://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/planet/planet-latest.osm.bz2
```

```
bzcat planet-latest.osm.bz2 | osmconvert - --drop-author --out-o5m > planet.o5m
osmfilter planet.o5m --drop-author --keep='boundary=administrative boundary=political' | bzip2 > planet.osm.bz2
```

# Build

```
docker build -t overpass-api:0.7.53 .
```

# Run

```
docker run -d -p 50080:80 overpass-api:0.7.53
```

wait till it start http server

```
docker logs PID
```

# Test

```
http://localhost:50080/api/interpreter?data=[out:json];is_in(53,10);rel(pivot);out geom;
```

## Credits

Built for [Geo Pointer](https://github.com/dmitry/geo_pointer) - API built with ruby sinatra to retrieve hierarchical bounding shapes of the administrative regions from OSM data through Overpass API from points.
