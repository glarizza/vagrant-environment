class vagrant::aptitude {

  exec { 'aptitude_update':
    command     => 'aptitude update',
    refreshonly => true,
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
  }
  
  exec { "import-key":
    user    => root,
    command => "/usr/bin/wget -q -O - http://apt.puppetlabs.com/ops/4BD6EC30.asc | apt-key add -",
    unless  => "/usr/bin/apt-key list | grep -q 4BD6EC30",
    notify  => Exec["aptitude_update"],
    before  => File['mcollective_repo'],
  }

  file { 'kumina_repo':
    ensure  => file,
    path    => '/etc/apt/sources.list.d/kumina_repo.list',
    content => 'deb http://debian.kumina.nl/debian/ squeeze-kumina main',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Exec['aptitude_update'],
  }

  file { 'mcollective_repo':
      ensure  => file,
      path    => '/etc/apt/sources.list.d/mcollective_repo.list',
      content => 'deb http://apt.puppetlabs.com/ubuntu unstable main',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      notify  => Exec['aptitude_update'],
    }
  
  file { 'riptano':
    ensure  => file,
    path    => '/etc/apt/sources.list.d/riptano.list',
    content => 'deb http://debian.riptano.com/squeeze squeeze main',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Exec['aptitude_update'],
  }
  
  file { 'debian_experimental':
    ensure  => file,
    path    => '/etc/apt/sources.list.d/debian_experimental.list',
    content => 'deb http://ftp.de.debian.org/debian experimental main',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Exec[aptitude_update],
  }

  file { 'ignore_trust_violations':
    ensure  => file,
    path    => '/etc/apt/apt.conf.d/99untrusted',
    content => 'Aptitude::CmdLine::Ignore-Trust-Violations "true";',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    before  => File['riptano', 'mcollective_repo', 'debian_experimental', 'kumina_repo'],
    notify  => Exec['aptitude_update'],
  }
  
}