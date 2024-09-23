#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Add this line to wait for the database
while ! pg_isready -h $RENDER_POSTGRES_HOST -p $RENDER_POSTGRES_PORT -q -U $RENDER_POSTGRES_USER; do
  echo "Waiting for database..."
  sleep 2
done


# If you're using a Free instance type, you need to
# perform database migrations in the build command.
# Uncomment the following line:

bundle exec rails db:migrate