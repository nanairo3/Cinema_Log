#!/bin/bash
set -e

rm -f /my_app/tmp/pids/server.pid

bundle exec rake db:create
bundle exec rake db:migrate
rails runner MoviesAcquisitionApiSercvice.import

exec "$@"