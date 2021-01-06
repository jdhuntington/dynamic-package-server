FROM ruby:2.7

RUN bundle config --global frozen 1

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

