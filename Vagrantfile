# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = "croome.org"

Vagrant::Config.run do |config|
  config.vm.define :dev do |dev_config|
    dev_config.vm.box = "centos63"
    dev_config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
    dev_config.vm.network :hostonly, "172.15.15.2"
    dev_config.vm.host_name = "dev.#{domain}"
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "provision/manifests"
      puppet.module_path = "provision/modules"      
      puppet.manifest_file = "dev.pp"
      puppet.options = "--verbose --debug"
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
#       puppet.manifests_path = "provision/manifests"
#       puppet.module_path = "provision/modules"      
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
#       puppet.manifests_path = "provision/manifests"
#       puppet.module_path = "provision/modules"      
#     end
#   end
# end

