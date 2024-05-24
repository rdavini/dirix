server '192.168.15.63', user: 'rdavini', roles: %w{web app db}, port: 22
set :branch, 'main'
set :stage, :production
set :rails_env, 'production'