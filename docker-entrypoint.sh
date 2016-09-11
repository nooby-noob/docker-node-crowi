#!/bin/bash

export NODE_ENV=production
export MONGO_URI=${MONGO_URI:-mongodb://mongo:27017/crowi}
export REDIS_URL=${REDIS_URI:-redis://redis:6379/crowi}
export ELASTICSEARCH_URI=${ELASTICSEARCH_URI:-http://elasticsearch:9200/crowi}

exec "$@"