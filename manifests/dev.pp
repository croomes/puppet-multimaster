#
# dev.pp - bootstraps the dev server
#
$ruby = $::puppet_ruby_version
$deploy_to = $::puppet_bootstrap_deploy_to
$ruby_path = ["/usr/local/rvm/rubies/${ruby}/bin", "/usr/local/rvm/gems/${ruby}/bin", "/usr/bin", "/usr/sbin"]

# Setup Ruby
include rvm
rvm::system_user { vagrant: }
rvm_system_ruby {
  $ruby:
    ensure => 'present',
    default_use => true,
}
rvm_gem {
  'capistrano':
    name => 'capistrano',
    ruby_version => $ruby,
    ensure => latest,
    require => Rvm_system_ruby[$ruby],
}

# Temporary while we're writing the this, once it's on rubygems we can convert to an rvm_gem resource.
exec { 'capistrano_puppet':
  command => "gem install capistrano-puppet-1.0.0.gem",
  require => Rvm_gem['capistrano'],
  cwd     => "/vagrant/src/capistrano-puppet",
  path    => $ruby_path,
  creates => ["/usr/local/rvm/gems/$ruby/gems/$name"],
}

# Create our Capistrano config for puppet-bootstrap
file { $deploy_to:
  ensure  => directory,
  owner   => 'vagrant',
  group   => 'vagrant',
  before  => File["${deploy_to}/Capfile"]
}
file { "${deploy_to}/Capfile":
  ensure  => file,
  content => template('Capfile.erb'),
  owner   => 'vagrant',
  group   => 'vagrant',
  require => Exec['capistrano_puppet'],
}

# Deploy our puppet-bootstrap repo
exec { 'cap deploy:setup':
  require => File["${deploy_to}/Capfile"],
  cwd     => $deploy_to,
  path    => $ruby_path,
  user    => 'vagrant',
}
exec { 'cap deploy':
  require => File["${deploy_to}/Capfile"],
  cwd     => $deploy_to,
  path    => $ruby_path,
  user    => 'vagrant',
}
Exec['cap deploy:setup'] -> Exec['cap deploy']

