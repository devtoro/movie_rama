# README

# This is a Dockerized Rails application, named MovieRama.
** It is set up to run only in development and test env, NOT FOR production

- It lists a list of movies.
- The user is able to react to the movies by "liking" and "hating" a movie.
- Only a logged in user can react to a movie
- A user can sign up and create an account in order to create movies and react to them
- A user cannot react to a movie that he has created
- A user cannot update a movie that has been created by another user
- A user can sort a movie based on the creation date and on the reactions that each movie has
- A user can filter out movies per user
- A user can edit their profile

** Build with Ruby on Rails, version: ~> 6.0.3
** Ruby version: 2.6.3

## System dependencies
  - Docker
  - docker-compose (version 3.8)

## How to run the application with docker
```bash
docker-compose up

docker-compose exec web bundle exec rake db:setup
```
Then depending on your system configuration,
either visit the IP of the movierama_web on port 3000
or localhost on port 3000.

If you are using the dockerapp, just visit localhost:3000

## Without docker
- CD to the movie_rama directory
- run:
```bash
bundle install
```

```bash
bundle exec rake db:setup
bundle exec rails s
```

** You need to have ruby 2.6.3 installed along with the bundler gem

* You can login as an existing user (email: luke@jedi.com, password: movierama) or sign up to create a new account


## How to run the test suite
- With docker
```bash
docker-compose exec -e RAILS_ENV=test -e HUB_URL=http://chrome:4444/wd/hub web bundle exec rspec
```
- Withour docker
after you have run
```bash
bundle install
bundle exec rake db:create
```

run the command:
```bash
bundle exec rspec
```


