# docker-overpass-api
Docker Overpass API container

# Get filtered planet file

```
bzcat planet-latest.osm.bz2 | osmconvert - --drop-author --out-o5m > planet.o5m
osmfilter planet.o5m --drop-author --keep='boundary=administrative boundary=political' | bzip2 > planet.osm.bz2
```

# Build

```
docker build -t overpass-api:0.7.52 .
```

# Run

```
docker run -d -p 50080:80 overpass-api:0.7.52
```

wait till it start http server

```
docker logs PID
```

# Test

```
http://localhost:50080/api/interpreter?data=[out:json];is_in(53,10);rel(pivot);out geom;
```
