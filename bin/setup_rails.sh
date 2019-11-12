set -e

rm -f /my_app/tmp/pids/server.pid
bundle exec rake db:create
bundle exec rake db:migrate
rails runner MoviesAcquisitionApiSercvice.import
bundle exec rails s -p 3000 -b '0.0.0.0'