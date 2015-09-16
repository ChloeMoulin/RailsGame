OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '765551106925071', '77e486e005e8f0c5af695476821ee583', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end