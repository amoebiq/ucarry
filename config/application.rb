require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UCarry
  class Application < Rails::Application

    config.logger = Logger.new(STDOUT)



    config.active_record.raise_in_transactional_callbacks = true

    config.active_job.queue_adapter = :delayed_job



    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
                 :headers => :any,
                 :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                 :methods => [:get, :post, :options, :delete, :put]
      end
    end



  end
end
