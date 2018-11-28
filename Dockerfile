# ----------
# RUN STAGE
# - Everything ready for the bot to run
# ----------

FROM ruby:2.5-alpine as run

# Dependencies
RUN apk add --no-cache build-base libsodium-dev
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development

# Code
COPY awesomo.rb awesomo.rb
COPY lib lib

# Run
ENTRYPOINT bundle exec ruby awesomo.rb

# ----------
# TEST STAGE
# - Add test dependencies and code and run tests
# ----------

FROM run as test

# Dependencies
RUN bundle install

# Code
COPY test test

# Run
ENTRYPOINT ruby -e 'ARGV.each { |f| require f }' ./test/test*.rb
