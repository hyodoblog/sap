require_relative 'boot'

require "rails"
require 'csv'
require 'net/http'
require 'uri'
require 'json'
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.template_engine false 
      g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      g.system_tests = nil
      g.template_engine :slim
    end
    
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    # config.action_mailer.delivery_method = :sendgrid_actionmailer
    # config.action_mailer.sendgrid_actionmailer_settings = {
    #   api_key: ENV['SENDGRID_API_KEY'],
    #   raise_delivery_errors: true
    # }

    # whenever config
    config.autoload_paths += %W(#{config.root}/lib)
    config.enable_dependency_loading = true
  end
end
