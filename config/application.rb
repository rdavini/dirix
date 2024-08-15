require_relative "boot"

require "rails/all"
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DirixUserServiceRor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.autoload_paths << Rails.root.join('lib')
    config.active_record.encryption.primary_key = "OiqXR88smIh2WP6I29SJ1xy2Ah2v13pg"
    config.active_record.encryption.deterministic_key = "jsatm4LLQu34QXGj9yPMBM6p5k6m06hX"
    config.active_record.encryption.key_derivation_salt = "21IgZwsr7WykLiavZCnBBatDSFoi6ezF"
  end
end
