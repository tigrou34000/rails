FROM ruby:2.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /api_server
WORKDIR /api_server
ADD Gemfile /api_server/Gemfile
RUN bundle install
ADD . /api_server


