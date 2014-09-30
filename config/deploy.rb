set :application, 'mappo2'

set :stages, ['staging', 'production']

set :scm, :git
set :repo_url, 'git@github.com:martinosecchi/mappo2.git'
#https://github.com/martinosecchi/mappo2.git
set :deploy_to, '/www/ict4g/ict4g.apps/mappo2'
set :user, "ict4g"
set :use_sudo, false

server 'dev.ict4g.org',:app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end