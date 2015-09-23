OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "393699764147438", "c5807ccaf3c2ed3c604b5c4893047df1", {:provider_ignores_state => true, scope: 'email', info_fields: 'email'}
end