#
# default.pp - defines defaults for vagrant provisioning
#
$ruby = 'ruby-1.9.3-p286'
$ruby_path = ["/usr/local/rvm/rubies/$ruby/bin", "/usr/local/rvm/gems/$ruby/bin", "/usr/bin", "/usr/sbin"]

# use run stages for minor vagrant environment fixes
stage { 'pre': before    => Stage['main'] }

include rvm
rvm_system_ruby {
  $ruby:
    ensure => 'present',
    default_use => true;
}
rvm_gem {
  'capistrano':
    name => 'capistrano',
    ruby_version => $ruby,
    ensure => latest,
    require => Rvm_system_ruby[$ruby];
}
exec { 'gem install capistrano-puppet-1.0.0.gem':
  require => Rvm_gem['capistrano'],
  cwd     => "/vagrant/src/capistrano-puppet",
  path    => $ruby_path,
  creates => ["/usr/local/rvm/gems/$ruby/gems/capistrano-puppet-1.0.0"]
}
exec { 'cap deploy:setup':
  cwd     => "/vagrant",
  path    => $ruby_path,
}
exec { 'cap deploy':
  cwd     => "/vagrant",
  path    => $ruby_path,
}
Exec['gem install capistrano-puppet-1.0.0.gem'] -> Exec['cap deploy:setup'] -> Exec['cap deploy']
