source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# hashes password
gem 'bcrypt'
# makes fake users for development purposes should not be used in production, but this is just a sample project
gem 'faker'
# both of these are needed to show only x amount of users per page
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# 11.55 
gem 'carrierwave' # used for uploading an image
# used for resizing image
gem 'mini_magick'
gem 'fog'


#handles bootstrap and saas
gem 'bootstrap-sass'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'sqlite3'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring'
end

group :test do
	gem 'minitest-reporters'
	gem 'mini_backtrace'
	gem 'guard'
	gem 'guard-minitest'
end

group :production do
  gem 'pg'
  gem 'puma'
end

