FROM ruby:3.2.2-bookworm

RUN gem install bundler -v '2.3.14' && mkdir /app 
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app
