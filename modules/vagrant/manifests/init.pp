class vagrant {

  include vagrant::fixes

  $stomp_server  = 'stomp'
  $stomp_ip      = '192.168.56.10'
  $stomp_aliases = [
    'stomp.vagrant.internal',
    'aserver.vagrant.internal',
    'aserver',
  ]

  host { $stomp_server:
      ensure       => present,
      ip           => $stomp_ip,
      host_aliases => $stomp_aliases,
  }

  case $operatingsystem {
    debian,ubuntu: {
      class { 'vagrant::aptitude':
        stage => 'setup',
      }
    }
    redhat,centos,fedora: {
      class { 'vagrant::yum':
        stage => 'setup'
      }
    }
  }
}
