RailsGame::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false


  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.laposte.net",
    :port                 => 587,
    :user_name            => "c.moulin29@laposte.net",
    :password             => "adrien",
    :authentication       => :plain,
    :enable_starttls_auto => true
  }
  class DisableAssetsLogger
    def initialize(app)
      unless ENV[ 'LOG_ASSETS' ]
        puts "Deactivating asset logging."
        puts "To see asset requests in log, start with LOG_ASSETS=true env variable."
      end

      @app = app
      Rails.application.assets.logger = Logger.new('/dev/null')
    end

    def call(env)
      previous_level = Rails.logger.level
      Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index("/assets/") == 0 && ! ENV[ 'LOG_ASSETS' ]
      @app.call(env)
    ensure
      Rails.logger.level = previous_level
    end
  end
  Rails.application.config.middleware.insert_before Rails::Rack::Logger, DisableAssetsLogger if Rails.env.development?
  
end
