# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
RCaptcha::Application.config.secret_key_base = '45c1e4c8c044c4de1b681da2d15823b4799bb6ba47756051b34ebc420b6bb7fe9af60b3e0c1cf75a3f0844851b222ab6d50653cad0a3de4343ba24c207b7e958'
