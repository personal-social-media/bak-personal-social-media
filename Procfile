web: rm tmp/pids/* tmp/cache/* log/* -rf && bundle exec falcon serve --port 3000 -b http://0.0.0.0
background: bundle exec sidekiq
webpacker: bundle exec bin/webpack-dev-server
