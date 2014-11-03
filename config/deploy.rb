require 'bundler/capistrano'
require 'capistrano-rbenv'
set :rbenv_ruby_version, '1.9.3-p547'

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

#run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"

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