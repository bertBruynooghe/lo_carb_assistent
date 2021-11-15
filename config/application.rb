require_relative 'boot'
require_relative '../lib/service_worker_manager'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LoCarbAssistent
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = :nl

    config.middleware.unshift PwaManager
  end
end

Rails.application.configure do	
  config.action_view.default_form_builder = "FormBuilder"	
end
