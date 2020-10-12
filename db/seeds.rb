# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Users
#
[
  {
    full_name: 'Luke Skywalker',
    email: 'luke@jedi.com',
    password: 'movierama'
  },
  {
    full_name: 'Frodo Baggins',
    email: 'frodo@lotr.com',
    password: 'movierama'
  }
].each { |user_attrs| User.create user_attrs }

# Create movies
#
[
  {
    title: 'Ironman',
    description: 'This is ironamn. It is a gem from MARVEL',
    user: User.first
  },
  {
    title: 'Gladiator',
    description: 'This is Gladiator. An epic adventure of a man in roman times',
    user: User.first
  },
  {
    title: 'The Rockstar',
    description: 'This is the rockstar. About a kid who followed his dream',
    user: User.last
  },
  {
    title: 'The Pick of Destiny',
    description: 'This is the pick of destiny. About another kid whoh followe his dream, but a totally different concept',
    user: User.last
  }
].each { |movie_attrs| Movie.create movie_attrs }

# Create reactions
#
[
  { name: 'like', color: '#5e5efc' },
  { name: 'hate', color: '#f74040' }
].each { |reaction_attrs| Reaction.create reaction_attrs }