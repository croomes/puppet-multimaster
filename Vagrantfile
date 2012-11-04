# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set our target Ruby and Puppet versions:
$puppet_ruby_version = "ruby-1.9.3-p286"
$puppet_version = "3.0.1"
$puppet_bootstrap_deploy_to = "/tmp/puppet-bootstrap"

domain = "croome.org"

Vagrant::Config.run do |config|
  config.vm.define :dev do |dev_config|
    dev_config.vm.box = "centos63"
    dev_config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
    dev_config.vm.network :hostonly, "172.15.15.2"
    dev_config.vm.host_name = "dev.#{domain}"
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.manifest_file = "dev.pp"
      puppet.options = "--templatedir=/vagrant/templates --verbose --debug"
      puppet.facter = {
        "puppet_ruby_version" => $puppet_ruby_version,
        "puppet_version" => $puppet_version,
        "puppet_bootstrap_deploy_to" => $puppet_bootstrap_deploy_to,
      }
    end
  end
end

# Vagrant::Config.run do |config|
#   config.vm.define :master do |master_config|
#     master_config.vm.box = "centos63"
#     master_config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
#     master_config.vm.network :hostonly, "172.15.15.3"
#     master_config.vm.host_name = "puppet1.#{domain}"
#     config.vm.provision :puppet do |puppet|
#       puppet.manifests_path = "manifests"
#       puppet.module_path = "modules"      
#     end
#   end
# end
# 
# Vagrant::Config.run do |config|
#   config.vm.define :master do |master_config|
#     master_config.vm.box = "centos63"
#     master_config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
#     master_config.vm.network :hostonly, "172.15.15.4"
#     master_config.vm.host_name = "puppet2.#{domain}"
#     config.vm.provision :puppet do |puppet|
#       puppet.manifests_path = "manifests"
#       puppet.module_path = "modules"      
#     end
#   end
# end

