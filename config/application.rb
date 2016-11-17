require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Storyline
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.autoload_paths += %W(#{config.root}/lib)

    # setting up environment variables like ENV['hello_world']
    # If we place this code in initializers/* even in before_configure or
    # before_initialize block, variable ENV would not be set before
    # environment/* files
    env_file = Rails.root.join('config', 'environment_variables.yml').to_s
    if File.exists?(env_file)
      YAML.load_file(env_file)[Rails.env].try(:each) do |key, value|
        ENV[key.to_s] = value
      end # end YAML.load_file
    end # end if File.exists?

    # autoload STI model files
    config.autoload_paths += %W(#{config.root}/app/models/moments)

    config.generators do |g|
      g.test_framework :rspec, fixture_replacement: :factory_girl
      g.fixture false
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
      g.request_specs false
    end
  end
end
