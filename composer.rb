gsub_file "Gemfile", "https://rubygems.org", "http://ruby.taobao.org"

gem 'mysql2'
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

gem "devise"



after_bundle do
  inject_into_file 'config/application.rb', after: "# -- all .rb files in that directory are automatically loaded.\n" do <<-'RUBY'
    config.generators.template_engine = :slim
    config.generators.scaffold_controller = "i18n_scaffold_controller"
    config.i18n.default_locale = "zh-CN"
  RUBY
  end

  inject_into_file 'config/environments/development.rb', after: "# -- all .rb files in that directory are automatically loaded.\n" do <<-'RUBY'
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  RUBY
  end

  generate "simple_form:install --bootstrap"
  generate "devise:install"
  generate "devise", "user"
  generate "settings", "setting"
  generate "rails_settings_ui:install"


  rake "db:migrate"

  run "mkdir -p lib/templates/slim/scaffold/"
  run "mkdir -p lib/templates/rails/i18n_scaffold_controller"
  run "mkdir -p lib/generators/rails/i18n_scaffold_controller/templates/"


  #init guard config
  run "guard init"

  #fetch default .gitignore
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/config/.gitignore -O .gitignore"

  #config rails_settings_ui
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/initializers/rails_settings_ui.rb -O config/initializers/rails_settings_ui.rb"
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/models/setting.rb -O app/models/setting.rb"

  #custom scaffold slim template to support i18n auto
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/scaffold/_form.html.slim -O lib/templates/slim/scaffold/_form.html.slim"
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/scaffold/edit.html.slim -O lib/templates/slim/scaffold/edit.html.slim"
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/scaffold/index.html.slim -O lib/templates/slim/scaffold/index.html.slim"
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/scaffold/new.html.slim -O lib/templates/slim/scaffold/new.html.slim"
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/scaffold/show.html.slim -O lib/templates/slim/scaffold/show.html.slim"

  #custom scaffold controller template to support i18n auto
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/i18n_scaffold_controller/controller.rb -O lib/templates/rails/i18n_scaffold_controller/controller.rb"


  #define new scaffold controller to auto generate i18n in config/local/zh-CN.yml
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/i18n_scaffold_controller/i18n_scaffold_controller_generator.rb -O lib/generators/rails/i18n_scaffold_controller/i18n_scaffold_controller_generator.rb"

  #default zh-CN file
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/config/locales/zh-CN.yml -O config/locales/zh-CN.yml"

  #suppport sms, use china_sms
  run "wget https://raw.githubusercontent.com/seaify/rails-application-templates/master/lib/sms.rb -O lib/sms.rb"

  git :init
  git add: '.'
  git commit: "-a -m 'Initial commit'"
end