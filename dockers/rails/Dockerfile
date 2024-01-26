FROM ruby:3.2.2-bookworm

RUN gem install bundler -v '2.3.14' && apt update -qq && apt install -y nodejs npm vim libvips42 && npm install -g n && n 20.10.0 && npm install -g yarn && mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app
