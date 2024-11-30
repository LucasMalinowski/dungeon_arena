FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
RUN rails assets:precompile

RUN sudo chmod -R 700 ./tmp/db
RUN sudo chown -R $USER:$USER .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]