OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '766226123524236', '2cac0f467b094c8f312925874bb31f6e', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}, :scope => 'email,user_birthday', :display => 'popup'}
end