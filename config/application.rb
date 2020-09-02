require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GlobalEncounters
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # ActionMailer::Base.smtp_settings = {

    #   address: 'smtp.gmail.com', domain:  'mail.google.com', port:  587, user_name:  'bilalarshad1011@gmail.com', password:  '4262935b', 
    #   authentication:  'login', enable_starttls_auto:  true	
    # }
  end
end
