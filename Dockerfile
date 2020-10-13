FROM ruby:2.6.3

# Install yarn and latest node
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get update && apt-get install -y yarn nodejs

# Install google-chrome for debian
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb || apt update && apt-get install -f -y

# Install chrome driver
RUN wget -N https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip -P ~/
RUN unzip ~/chromedriver_linux64.zip -d ~/
RUN rm ~/chromedriver_linux64.zip
RUN mv -f ~/chromedriver /usr/local/bin/chromedriver
RUN chown root:root /usr/local/bin/chromedriver
RUN chmod 0755 /usr/local/bin/chromedriver

WORKDIR /home/movierama/application
COPY ./movie_rama/* /home/movierama/application/

RUN gem install bundler
RUN bundle install
RUN yarn install
CMD ["rails", "server", "-b", "0.0.0.0"]