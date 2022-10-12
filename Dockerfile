FROM ruby:3.0.4

WORKDIR /icalialabs-firebase

RUN apt-get update

COPY . .

RUN bundle install

CMD [ "puma" ]
