#!/bin/sh
RAILS_PORT=8080
if [ -n "$PORT" ]; then
  RAILS_PORT=$PORT
fi

# migration
bundle exec rails db:migrate RAILS_ENV=production

# precompile
bundle exec rake assets:precompile RAILS_ENV=production

# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

# cron
bundle exec whenever --update-crontab
cron

# start rails app
bundle exec rails s -p $RAILS_PORT -b 0.0.0.0