FROM ruby:3.0.0

RUN apt-get update -qq \
    && apt-get install -y build-essential nodejs 
    
RUN apt-get update && apt-get install -y curl apt-transport-https wget \ 
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

RUN mkdir /webapp
WORKDIR /webapp
ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock
RUN bundle install
ADD . /webapp


RUN mkdir -p tmp/sockets