FROM ruby:2.5-alpine

RUN apk add --no-cache build-base

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT ["bundle", "exec", "ruby", "awesomo.rb"]
