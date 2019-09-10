# config valid only for current version of Capistrano
lock '3.8.0'

set :application, 'platform'
set :repo_url, 'git@github.com:metaware/platform.git'
set :deploy_to, "/var/www/#{fetch :application}"
set :format, :pretty
set :pty,  false
set :keep_releases, 4

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # do something
    end
  end

  task :restart do
    on :all, in: :sequence do
      # invoke 'nginx:restart'
      # invoke 'elasticsearch:start'
      invoke 'unicorn:legacy_restart'
      # invoke 'delayed_job:restart'
    end
  end

end

namespace :nginx do
  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command do
      on roles(:web) do |host|
        execute "service nginx #{command}"
      end
    end
  end
end

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end