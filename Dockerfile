FROM ruby:2.5.7

RUN mkdir /notification_centre
WORKDIR /notification_centre
COPY Gemfile /notification_centre/Gemfile
COPY Gemfile.lock /notification_centre/Gemfile.lock
COPY . /notification_centre
RUN gem install bundler
RUN bundle install
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]