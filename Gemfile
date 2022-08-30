source 'http://rubygems.org'

gem 'rails', '3.1.12'
gem 'gravatar_image_tag'
gem 'paperclip'
gem 'uuidtools'
gem 'rubyzip'
gem 'nokogiri'
gem 'devise'

group :production do
	gem 'therubyracer'
end

group :development, :test do
  gem 'sqlite3'
end

group :development do
  gem 'rspec-rails'
end

group :test do
	gem 'rspec'
	gem 'webrat'
  gem 'factory_girl_rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
