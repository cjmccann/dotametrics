Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, ENV["STEAM_WEB_API_KEY"]
end

Rails.application.config.secret_key_base = ENV['SECRET_TOKEN']
