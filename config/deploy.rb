# config valid only for Capistrano 3.1
lock '3.2.1'

set :ssh_options, { forward_agent: true, port: 2224 }
# set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :application, 'utilities'
set :repo_url, 'git@github.com:nononoy/utilities.git'


set :deploy_to, '/home/deploy/utilities'

set :rvm_type, :user
set :rvm_ruby_version, '2.2.0'

set :puma_threads,    [4, 16]
set :puma_workers,    0

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"

set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to true if using ActiveRecord

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{log tmp/pids tmp/sockets vendor/bundle public/uploads}

set :keep_releases, 2

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  # after :publishing, :restart

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
end

after  "deploy:finishing", "deploy:restart"
