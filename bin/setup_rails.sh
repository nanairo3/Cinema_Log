set -e

rm -f /my_app/tmp/pids/server.pid
RAILS_ENV=${RAILS_ENV} bundle exec rake db:create
RAILS_ENV=${RAILS_ENV} bundle exec rake db:migrate
RAILS_ENV=${RAILS_ENV} rails runner MoviesAcquisitionApiSercvice.import
RAILS_ENV=${RAILS_ENV} bundle exec rails s -p 3000 -b '0.0.0.0'