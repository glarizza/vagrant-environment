class vagrant {

  class { "vagrant::fixes":
    stage   => 'setup',
  }

  $stomp_server  = 'stomp'
  $stomp_ip      = '192.168.56.10'
  $stomp_aliases = [
    'stomp.vagrant.internal',
    'aserver.vagrant.internal',
    'aserver',"${fqdn}"
  ]

  host { $stomp_server:
      ensure       => present,
      ip           => $stomp_ip,
      host_aliases => $stomp_aliases,
  }
  
  package { 'rubygems':
    ensure => present,
  }

  case $operatingsystem {
    debian,ubuntu: {
      class { 'vagrant::aptitude':
        stage => 'setup',
      }

      package { [ "ruby-dev", "rake", "irb" ]:
        ensure => installed,
      }
      
    }
    redhat,centos,fedora: {
      class { 'vagrant::yum':
        stage => 'setup',
      }

      package { 'java-1.6.0-openjdk':
        ensure => present,
      }
      
      package { "ruby-devel":
        ensure => installed,
      }
      
    }
  }
}
