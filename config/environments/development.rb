Callisto::Application.configure do
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

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

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
  config.assets.debug = false


  HOST = 'localhost:3000'
  if !ENV.nil? and ENV.has_key?('HOST_NAME')
    HOST = ENV['HOST_NAME']
  end
  
  # Google Drive
  # config.REDIRECT_URI  = 'http://localhost:3000/resources/google-api/callback
  config.REDIRECT_URI  = "http://#{HOST}/google/oauth_callback"
  config.CLIENT_SECRET = 'S8U0_zKWy1ds7ijVaixoXM5F'
  config.OAUTH_SCOPE   = 'https://www.googleapis.com/auth/drive'
  config.CLIENT_ID     = '416236884829-58tg9n917gt0vfksndpn1u0q9j3efpck.apps.googleusercontent.com'
  
  config.SCOPES = [
      'https://www.googleapis.com/auth/drive',
      'https://www.googleapis.com/auth/drive.file',
      'https://www.googleapis.com/auth/drive.install',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/plus.me'
  ]

end
