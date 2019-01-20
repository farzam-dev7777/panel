set :rails_env, :external
set :branch, :staging

server 'ec2-35-182-224-140.ca-central-1.compute.amazonaws.com', user: 'ubuntu', port: 4321, password: fetch(:password), roles: %w{web app}

set :deploy_via, :remote_cache
set :rvm_custom_path, '/usr/share/rvm/'
set :rvm_ruby_version, '2.5.1'

set :unicorn_rack_env, :external

set :ssh_options, {
  config: false,
  forward_agent: true,
  auth_methods: %w(publickey),
  user: 'ubuntu',
  paranoid: true,
  keys: %w(~/.ssh/seal-staging-aws.pem)
}

set :conditionally_migrate, true