Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, '941762279696-5t8ukai04s5llc3govvjicbbufv3bkac.apps.googleusercontent.com', 'crbrcAt8S0RiNfPYPnrmLROk',scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

end