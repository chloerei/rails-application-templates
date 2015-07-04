add_source 'http://ruby.taobao.org'

gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'jbuilder', '~> 2.0'
gem 'slim-rails'
gem 'simple_form', '~> 3.1.0'

gem 'annotate', '~> 2.6.6'
gem 'i18n-tasks', '~> 0.8.3'
gem 'comma', "~> 3.2.1"
gem 'rails-settings-ui', '~> 0.3.0'
gem 'rails-settings-cached', "0.4.1"
gem 'china_sms', :github => 'seaify/china_sms'

gem 'bcrypt'
gem 'enumerize'

#deployment
gem 'mina', require: false
gem 'mina-multistage', require: false
gem 'mina-sidekiq', require: false
gem 'mina-unicorn', require: false

# app server
gem 'unicorn'
# app configuration
gem 'figaro'


#development
gem_group :development do
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-migrate'
  gem 'guard-annotate'
  gem 'quiet_assets'
  gem 'rails_layout'
end

gem_group :development, :test do
  gem 'pry'
  gem 'web-console', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spring'
end

gem_group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'ffaker'
end

if yes?("Would you like to install Devise?")
  gem "devise"
  generate "devise:install"
  model_name = ask("What would you like the user model to be called? [user]")
  model_name = "user" if model_name.blank?
  generate "devise", model_name
end

generate "simple_form:install"

after_bundle do
  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end