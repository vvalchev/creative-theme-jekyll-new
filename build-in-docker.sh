#!/bin/sh

if [ -z "$1" ]; then
  docker run -it --rm \
    --workdir /app \
    --volume `pwd`:/app \
    --publish 4000:4000 \
    --publish 4001:4001 \
    ruby \
    /app/build-in-docker.sh build
else
  bundle install
  bundle exec jekyll serve \
    -H 0.0.0.0 \
    --trace \
    --watch \
    --livereload \
    --livereload-port 4001
fi
