
FROM ruby:3.3
RUN apt-get update -qq && apt-get install -y vim gosu

RUN mkdir /backend
WORKDIR /backend
COPY Gemfile /backend/Gemfile
COPY Gemfile.lock /backend/Gemfile.lock

RUN gem update --system
RUN bundle update --bundler

RUN bundle install
COPY . /backend

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]