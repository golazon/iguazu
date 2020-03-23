source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('./.ruby-version').strip

# Rails (base)
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem "puma", ">= 4.3.3"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Services
gem 'pg', '~> 1.2'

# Utility
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem "nokogiri", ">= 1.10.8"
gem 'typhoeus', '~> 1.3'

group :development do
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'derailed_benchmarks'

  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-performance'
  # temporary for ci to work
  gem 'rubocop-rspec'
end

group :test do
  gem 'shoulda-context'
  gem 'timecop'
  gem 'webmock'
end
