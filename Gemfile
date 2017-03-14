source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.19'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'underlock'

gem 'devise'
gem 'will_paginate'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'draper', '~> 3.0.0.pre1'
gem 'ransack'
gem 'activemodel-serializers-xml'
gem 'simple-form-datepicker'

# gem 'rails-assets-fontawesome', source: 'https://rails-assets.org'
gem 'rails-assets-JustGage', source: 'https://rails-assets.org'
gem 'rails-assets-raphael', source: 'https://rails-assets.org'
gem 'rails-assets-qTip2', source: 'https://rails-assets.org'
gem 'rails-assets-sweetalert', source: 'https://rails-assets.org'
gem 'rails-assets-toastr', source: 'https://rails-assets.org'
gem 'rails-assets-rateyo', source: 'https://rails-assets.org'

gem 'activerecord-sortable'
gem 'breadcrumbs_on_rails'

gem 'whenever', :require => false

gem 'font-awesome-rails', '~> 4.5'

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-ui-rails', '~> 5.0.5'
gem 'rails-jquery-ui-sortable'

gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', branch: :master
gem 'amoeba'
gem "cancan"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "paranoia", "~> 2.2"
gem 'simple_form'
gem "cocoon"
gem 'will_paginate-bootstrap'
gem 'mailboxer'
gem 'nested_form'

gem 'rails-breadcrumbs'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


group :production, :staging do
  gem 'unicorn'
  # gem 'puma'
end

group :development, :test do
  # gem 'capistrano-unicorn-nginx', '~> 3.2.0'
  # gem 'thin'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano3-unicorn'
  # gem 'capistrano3-delayed-job', '~> 1.0'
  # gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  # gem 'byebug'
  # gem 'quiet_assets'
  # gem 'web-console', '~> 2.0'
  # gem 'spring'
  # gem 'better_errors'
  # gem "binding_of_caller"
  # gem 'letter_opener'
end