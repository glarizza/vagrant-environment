class vagrant::yum {

  package { 'java-1.6.0-openjdk':
    ensure => present,
  }

  yumrepo { 'puppet-prosvc':
  	descr		=> "Puppet Professional Services Module",
  	enabled		=> 1,
  	gpgcheck	=> 0,
  	baseurl		=> "http://yum.puppetlabs.com/prosvc/5/${architecture}",
  }

  yumrepo { 'mnx-repo':
  	descr		=> "MNX Solutions Repo",
  	enabled		=> 1,
  	gpgcheck	=> 0,
  	baseurl		=> "http://yum.mnxsolutions.com/",
  }
  
  yumrepo { 'faro-java':
    descr     => "Faro Java Repo",
    enabled   => 1,
    gpgcheck  => 0,
    baseurl   => "http://faro.puppetlabs.lan/yum/java/5/${architecture}",
  }
  
}
