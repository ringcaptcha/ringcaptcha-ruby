# Rails Example App

## Overview

This is an example app built on Rails that uses the RingCaptcha Ruby gem. It adds the RingCaptcha JS widget to a blank page, and after entering the PIN code, the user must click on "Check RC" button which will show the details of the verification, in the logs and a reduced subset of items in the HTML site.

## Getting Started

In order to run the example please follow the next steps:

1. git clone this repository
2. `cd example`
3. `rvm install ruby-2.3.0` is using RVM, otherwise make sure your version of Ruby is at least 2.3.0
4. `bundle install` to install all dependencies
5. `bin/rake db:migrate RAILS_ENV=development` to run all migrations to create basic structure
6. `dotenv rails server` bring up the server
7. Open [localhost:3000](localhost:3000) in your browser
