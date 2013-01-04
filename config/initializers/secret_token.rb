# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Golfstats::Application.config.secret_token = ENV['SECRET_TOKEN'] || 'b976692597d919eb9bf64a5ef78dddfd639d6310146ee69919ec3b3e9275287845c05188f90fdd855c3112bdc239449a0e76e84b2523379dcd9de75a628a0e15'
