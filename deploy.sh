set +e
cd /var/www/ActorConnection/ActorConnection
git pull
bin/bundle install --without test development
bin/bundle exec rails assets:precompile RAILS_ENV=production
bin/bundle exec rails db:migrate RAILS_ENV=production
cat tmp/pids/server.pid |xargs kill -9
bin/bundle exec rails s -e production