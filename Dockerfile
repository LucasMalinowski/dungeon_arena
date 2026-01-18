FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl npm nodejs yarn postgresql-client

# Install JS bundlers globally if using esbuild or tailwind CLI
RUN npm install -g esbuild tailwindcss

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
RUN rails assets:precompile

RUN chown -R root:root .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]