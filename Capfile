require 'capistrano'
require 'rubygems'
require 'puppet/capistrano'

set :application, "Puppet Master Bootstrap"
#set :current_path, "/etc/puppet"
set :deploy_to, "/tmp/puppet-bootstrap"
set :deploy_via, :export
set :use_sudo, false
set :user, "vagrant"
set :password, "vagrant"
set :scm, :git
set :repository, "git://github.com/croomes/puppet-conf.git"

role :web, 'localhost'
