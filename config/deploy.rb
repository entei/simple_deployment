require 'bundler/capistrano'
load 'deploy/assets'

set :repository, 'git@github.com:entei/simple_deployment.git'
set :scm, :git

server '5.175.165.206', :app, :web, :db, :primary => true
set :port, 22

set :ssh_options, { :forward_agent => true }
default_run_options[:shell] = 'bash -l'

set :user, 'deployer'
#set :group, 'deployer'
set :use_sudo, false
set :rails_env, 'production'

set :project_name, 'simple_deployment'

set :deploy_to, "/var/www/#{ project_name }"

desc "Restart of Unicorn"
task :restart, :except => { :no_release => true } do
  run "kill -s USR2 `cat /var/www/#{ project_name }/tmp/pids/unicorn.pid`"
end

desc "Start unicorn"
task :start, :except => { :no_release => true } do
  run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D -E #{ rails_env }"
end

desc "Stop unicorn"
task :stop, :except => { :no_release => true } do
  run "kill -s QUIT `cat /var/www/#{ project_name }/tmp/pids/unicorn.pid`"
end

after 'deploy:finalize_update', 'deploy:symlink_db'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end
