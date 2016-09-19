# docker-overpass-api
Docker Overpass API container

# Get filtered planet file

```
bzcat planet-latest.osm.bz2 | osmconvert - --drop-author --out-o5m > planet.o5m
osmfilter planet.o5m --drop-author --keep='boundary=administrative boundary=political' | bzip2 > planet.osm.bz2
```

# Build

```
docker build  -t  overpass-api:0.7.52 .
```
