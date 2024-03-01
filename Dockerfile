FROM ruby:3.2.3-alpine3.19

LABEL maintainer="Fabiano Santos Florentino"
LABEL version="0.1"
LABEL description="Docker image for Ruby on Rails development"
LABEL appname="Black Pearl"

ENV PATH="/usr/local/bundle/bin:${PATH}"
ENV RUBY_YJIT_ENABLE=1

COPY . /app

WORKDIR /app

RUN apk update && apk upgrade --no-cache \
  && apk add --no-cache libpq-dev build-base git bash tzdata gcompat postgresql \
  && gem install rails railties bundler \
  && bundle install --jobs 2 --no-cache \
  && bundle exec bootsnap precompile

EXPOSE 3000

CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0 -p 3000"]
