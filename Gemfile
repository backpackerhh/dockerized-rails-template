# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "factory_bot_rails", "~> 6.4.3"
  gem "rspec-rails", "~> 6.1.0"
  gem "rubocop", "~> 1.60", require: false
  gem "rubocop-performance", "~> 1.20", require: false
  gem "rubocop-rails", "~> 2.23", require: false
  gem "rubocop-rspec", "~> 2.26", require: false
end

group :test do
  gem "database_cleaner-active_record", "~> 2.1"
end
