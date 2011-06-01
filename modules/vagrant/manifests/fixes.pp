class vagrant::fixes {

  host { $hostname:
    ensure => present,
    ip => '127.0.1.1',
    host_aliases => "${hostname}.vagrant.internal",
  }

  if $operatingsystem == CentOS or $operatingsystem == RHEL {	
	service { 'iptables':
	  ensure	=> stopped,
	  hasstatus	=> true,
	  status	=> '/sbin/service iptables status',
	  stop		=> '/sbin/service iptables stop',
	}
  } 
}
