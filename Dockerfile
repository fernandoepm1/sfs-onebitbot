FROM ruby:2.5.1

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  build-essential libpq-dev

ENV APP_PATH /onebitbot
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . $APP_PATH

CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0"]
