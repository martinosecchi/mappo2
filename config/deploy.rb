require 'bundler/capistrano'
require 'capistrano-rbenv'
#set :rbenv_ruby_version, '1.9.3-p547'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '1.9.3-p547'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


set :application, 'mappo2'

set :scm, :git
set :repository, 'https://github.com/martinosecchi/mappo2.git'#'git@github.com:martinosecchi/mappo2.git'

set :default_stage, 'production'

set :deploy_to, '/www/ict4g/ict4g.apps/mappo2'
set :user, "ict4g"
set :use_sudo, false

set :bundle_gemfile,  "Gemfile"
set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags,    "--quiet"

server 'dev.ict4g.org',:app, :web, :db, :primary => true


# Run migrations
after "deploy", "deploy:migrate"
after "deploy:migrate", "deploy:cleanup"

set :linked_files, %w{config/database.yml}

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

# namespace :bundle do

#   desc "run bundle install"
#   task :install do
#     run "cd #{current_path} && bundle install"
#   end
# end