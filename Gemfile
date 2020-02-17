# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo|
  repo = "#{repo}/#{repo_name}" unless repo.include?('/')
  "https://github.com/#{repo}.git"
end

ruby '2.6.5'
gem 'rails', '5.2.4'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails'
gem 'puma', '~> 3.11'
gem 'pg', '~> 1.2', '>= 1.2.2'

gem 'bcrypt'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'rails-i18n', '~> 5.1' # For 5.0.x, 5.1.x and 5.2.x
gem 'activerecord-nulldb-adapter'
gem "rubyzip", ">= 1.3.0"

# excel import
gem 'roo'
# excel export
gem 'axlsx'
gem 'zip-zip'

# seo
gem 'sitemap_generator'
gem 'meta-tags'
gem 'google-analytics-rails'

# View
gem 'autoprefixer-rails'
gem 'bootstrap', '~> 4.4.1'
gem 'bootstrap4-datetime-picker-rails'
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'sassc-rails'
gem 'slim-rails'
gem 'sprockets', '~> 4.0'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: :mri
  gem 'capybara'
  gem 'faker'
  gem 'html2slim'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  # Cron
  gem 'whenever', :require => false
end