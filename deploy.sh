set +e
cd /var/www/ActorConnection/ActorConnection
git pull
sudo bundle install --without test development
sudo bundle exec rails assets:precompile RAILS_ENV=production
sudo bundle exec rails db:migrate RAILS_ENV=production
cat tmp/pids/server.pid |xargs kill -9
sudo bundle exec rails s -e production