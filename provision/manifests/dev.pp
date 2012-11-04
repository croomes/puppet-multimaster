#
# default.pp - defines defaults for vagrant provisioning
#
$ruby = 'ruby-1.9.3-p193'
$ruby_path = ["/usr/local/rvm/rubies/$ruby/bin", "/usr/local/rvm/gems/$ruby/bin", "/usr/bin", "/usr/sbin"]

# use run stages for minor vagrant environment fixes
stage { 'pre': before    => Stage['main'] }

include rvm
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
user { 'vagrant':
  groups  => ["vagrant", "wheel", "rvm"],
  require => Rvm_system_ruby[$ruby],
}


# Temporary while we're writing the this, once it's on rubygems we can convert to an rvm_gem resource.
exec { 'capistrano_puppet':
  command => "gem install capistrano-puppet-1.0.0.gem",
  require => Rvm_gem['capistrano'],
  cwd     => "/vagrant/src/capistrano-puppet",
  path    => $ruby_path,
  #creates => ["/usr/local/rvm/gems/$ruby/gems/$name"]
}
exec { 'cap deploy:setup':
  require => Exec['capistrano_puppet'],
  cwd     => "/vagrant",
  path    => $ruby_path,
  user    => 'vagrant',
}
exec { 'cap deploy':
  require => Exec['capistrano_puppet'],
  cwd     => "/vagrant",
  path    => $ruby_path,
  user    => 'vagrant',
}
Exec['cap deploy:setup'] -> Exec['cap deploy']
