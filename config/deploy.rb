require 'bundler/capistrano'
default_run_options[:pty] = true

set :application, "merchants"
set :repository,  "git@github.com:Shelvak/Merchants.git"
set :deploy_to, '/home/eltonel/ruby/'
set :scm, :git
#set :port, 26
set :user, 'eltonel'
set :deploy_via, :remote_cache
#set :rails_env, :production
#set :use_sudo, false
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :branch, 'master'
role :web, "http://merchant-seba.no-ip.org/"                          # Your HTTP server, Apache/etc
role :app, "http://merchant-seba.no-ip.org/"                          # This may be the same as your `Web` server
role :db,  "http://merchant-seba.no-ip.org/", :primary => true 

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  # desc "reload the database with seed data"
	task :seed do
		run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
	end
  
end