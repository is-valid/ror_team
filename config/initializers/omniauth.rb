require 'yaml'
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'WKEMaXYkT7prX2kdCYKyuw', 'GYreNZWU9fNcDWTEE1oWZRPwhVxS5C2UV5wWrm3HQc'
  #provider :facebook, '177826365724897', '42fd4861cb678f4de5e1ed1a8d7153e7'
  #provider :vkontakte, '3743416', 'KnfpGXxrSEMjh3gkGyWL'
  API_KEYS = YAML.load_file('config/environments/development.yml')
  provider :twitter, API_KEYS['API_KEYS']['twitter']['key'], API_KEYS['API_KEYS']['twitter']['secret']
  provider :facebook, API_KEYS['API_KEYS']['facebook']['key'], API_KEYS['API_KEYS']['facebook']['secret']
  provider :vkontakte, API_KEYS['API_KEYS']['vkontakte']['key'], API_KEYS['API_KEYS']['vkontakte']['secret']
end


#APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/your_file_name.yml")[RAILS_ENV]

#{"pusher"=>{"wss_host"=>"127.0.0.1", "wss_port"=>8080, "api_host"=>"127.0.0.1", "api_port"=>4567, "app_id"=>1, "app_key"=>"c46c644b78f84661ace01b35dffceabc", "app_secret"=>"15c85d0ce00c492888423aca73f65d19"},
# "API_KEYS"=>{"facebook"=>{"key"=>"177826365724897", "secret"=>"42fd4861cb678f4de5e1ed1a8d7153e7"},
#              "twitter"=>{"key"=>"WKEMaXYkT7prX2kdCYKyuw", "secret"=>"GYreNZWU9fNcDWTEE1oWZRPwhVxS5C2UV5wWrm3HQc"},
#              "vkontakte"=>{"key"=>"3743416", "secret"=>"KnfpGXxrSEMjh3gkGyWL"}}}
#Exiting
