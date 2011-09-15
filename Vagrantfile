Vagrant::Config.run do |config|
  # Change this box name depending on the system you want.
  #box = "squeeze64"
  #box = "centos5_64"
  #box = "rhel60_64"  #-> Vagrant Errors
  #box = "centos4_64" -> Vagrant Errors
  box = "snowleopard"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = box
  #config.vm.box_url = "http://puppetlabs.s3.amazonaws.com/pub/#{box}.box"
  config.vm.box_url = "http://127.0.0.1/boxes/#{box}.box"

  config.vm.customize do |vm|
    #vm.memory_size = 128    # Bumped this up since I'm only doing 2 nodes - for my own sanity.
    vm.memory_size = 512
    vm.cpu_count = 1
  end
  #['a','c','e'].each do |element|
  ['a', 'c'].each do |element|
    meta_vm = {
      'ip'   => '192.168.56.' + (element.sum(5) + 9).to_s,
      'name' => element + 'server',
      'vm'   => element.to_sym
    }

    config.vm.define meta_vm['vm'] do |avm|
      # The :name attribute causes vagrant to fail for me with Debian, RHEL 6, and CentOS 4.
      #   Oddly, it works in CentOS 55_64.
      #avm.vm.network(meta_vm['ip'], :adapter => 1, :name => 'vboxnet0')   # NOTE: This fails with RHEL and CentOS 4
      avm.vm.network(meta_vm['ip'], :adapter => 1)
      avm.vm.host_name = meta_vm['name']

      # This will provision the box using puppet
      Vagrant::Config.run do |subconfig|
        subconfig.vm.provision :puppet do |puppet|
          puppet.options        = "-v --vardir=/var/lib/puppet --ssldir=/var/lib/puppet/ssl --certname=#{meta_vm['name']}"
          puppet.module_path    = "modules"
          puppet.manifests_path = "manifests"
          puppet.manifest_file  = "site.pp"
        end
      end
    end
  end
end

# vim: set filetype=ruby :
