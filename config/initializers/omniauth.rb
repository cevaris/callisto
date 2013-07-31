

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 
  				 Rails.application.config.FACEBOOK_APP_ID, 
  				 Rails.application.config.FACEBOOK_APP_SECRET
end