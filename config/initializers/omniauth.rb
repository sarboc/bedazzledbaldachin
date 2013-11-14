OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, ENV["key"], ENV["secret"],
#            :scope => 'email,user_birthday,read_stream', :display => 'popup'
# end