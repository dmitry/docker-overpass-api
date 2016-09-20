FROM ubuntu:trusty

# no tty
ARG DEBIAN_FRONTEND=noninteractive

ARG OSM_VER=0.7.53
ENV EXEC_DIR=/srv/osm3s
ENV DB_DIR=/srv/osm3s/db

RUN build_deps="g++ make expat libexpat1-dev zlib1g-dev curl wget" \
  && set -x \
  && echo "#!/bin/sh\nexit 0" >/usr/sbin/policy-rc.d \
  && apt-get update \
  && apt-get install -y --force-yes --no-install-recommends \
       $build_deps \
       fcgiwrap \
       nginx \
  && rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default \
  && rm -rf /var/lib/apt/lists/* \
  && curl -o osm-3s_v$OSM_VER.tar.gz http://dev.overpass-api.de/releases/osm-3s_v$OSM_VER.tar.gz \
  && tar -zxvf osm-3s_v${OSM_VER}.tar.gz \
  && cd osm-3s_v* \
  && ./configure CXXFLAGS="-O2" --prefix="$EXEC_DIR" \
  && make install

RUN cd .. \
  && rm -rf osm-3s_v*

WORKDIR /usr/src/app

COPY planet.osm.bz2 /planet.osm.bz2

ARG PLANET_FILE=/planet.osm.bz2

RUN set -x && /srv/osm3s/bin/init_osm3s.sh "$PLANET_FILE" "$DB_DIR" "$EXEC_DIR" \
  && rm -f "$PLANET_FILE"

RUN mkdir $DB_DIR/rules
COPY areas.osm3s /srv/osm3s/db/rules/areas.osm3s

COPY nginx.conf /etc/nginx/nginx.conf
COPY overpass /etc/init.d
COPY docker-start /usr/local/sbin

CMD ["/usr/local/sbin/docker-start"]

EXPOSE 80
