FROM ruby:2.2.0

RUN apt-get update && \
    apt-get install -y nodejs

COPY app /app

WORKDIR /app

RUN bundle install 

ENTRYPOINT rails server -b 0.0.0.0

