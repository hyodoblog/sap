# #!/bin/sh
# RAILS_PORT=3000
# if [ -n "$PORT" ]; then
#   RAILS_PORT=$PORT
# fi

# # create database
# #bundle exec rails db:create

# # migration
# bundle exec rails db:migrate

# # precompile
# bundle exec rake assets:precompile RAILS_ENV=production

# # Remove a potentially pre-existing server.pid for Rails.
# rm -f tmp/pids/server.pid

# # cron
# bundle exec whenever --update-crontab
# cron

# # sitemap
# # send google and bing to ping
# bundle exec rails sitemap:refresh

# # start rails app
# bundle exec rails s -p $RAILS_PORT -b 0.0.0.0