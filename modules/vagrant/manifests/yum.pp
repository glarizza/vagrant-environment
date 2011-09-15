class vagrant::yum {

  Yumrepo { notify => Exec['yum-makecache'] }

  yumrepo { 'puppet-prosvc':
  	descr		=> "Puppet Professional Services Module",
  	enabled		=> 1,
  	gpgcheck	=> 0,
  	baseurl		=> "http://yum.puppetlabs.com/prosvc/5/${architecture}",
  }
  
  yumrepo { 'puppet-base':
  	descr		=> "Puppet Base Repo",
  	enabled		=> 1,
  	gpgcheck	=> 0,
  	baseurl		=> "http://yum.puppetlabs.com/base/",
  }
  
  yumrepo { 'puppet-el-product':
    descr     => "Puppet RHEL Product Repo",
    enabled   => 1,
    gpgcheck  => 0,
    baseurl   => "http://yum.puppetlabs.com/el/${lsbmajdistrelease}/products/${architecture}"
  }
  
  yumrepo { 'puppet-el-dependencies':
    descr     => "Puppet RHEL Dependencies Repo",
    enabled   => 1,
    gpgcheck  => 0,
    baseurl   => "http://yum.puppetlabs.com/el/${lsbmajdistrelease}/dependencies/${architecture}"
  }

  yumrepo { 'mnx-repo':
  	descr		=> "MNX Solutions Repo",
  	enabled		=> 1,
  	gpgcheck	=> 0,
  	baseurl		=> "http://yum.mnxsolutions.com/",
  }
  
  yumrepo { "EPEL":
    baseurl => "http://download.fedoraproject.org/pub/epel/${lsbmajdistrelease}/${architecture}",
    descr => "The EPEL repository",
    enabled => "1",
    gpgcheck => "0",
  }
  
  exec { 'yum-makecache':
    command     => '/usr/bin/yum makecache',
    refreshonly => true,
  }
  
  if $operatingsystemrelease >= '6.0' {
    file { '/selinux/enforce':
      ensure => present,
      content => "0",
    }
  }
  
  if $operatingsystemrelease < '6.0' {
    yumrepo { 'karan-32':
      descr   => "Karanbir Singh Ruby Repo",
      enabled   => 1,
      gpgcheck  => 0,
      baseurl   => "http://centos.karan.org/el5/ruby187/i386",
    }
    
    yumrepo { 'karan-x64':
      descr   => "Karanbir Singh Ruby Repo",
      enabled   => 1,
      gpgcheck  => 0,
      baseurl   => "http://centos.karan.org/el5/ruby187/${architecture}",
    }
    
    exec { "Kill_Selinux":
      command => "/usr/sbin/setenforce 0",
      unless  => "/bin/cat /selinux/enforce | grep 0"
    }
  }
}
