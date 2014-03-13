# -*- mode: ruby -*-
# vi: set ft=ruby :

$LOAD_PATH << '.'
require 'Params'

params = Params.get
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


  config.vm.network :private_network, ip: params[:server_ip]

  config.vm.synced_folder params[:www_dir], '/var/www',
                          create: true, 
                          owner: 'www-data', 
                          group: 'www-data'
  # config.vm.synced_folder '../VirtualBoxVMs', '/VirtualBoxVMs',
  #                         create: true, owner: 'vagrant', group: 'vagrant'

  config.vm.provider :virtualbox do |vb, override|
    vb.gui = false
    vb.customize ['modifyvm', :id, '--memory', params[:memory]]
    override.vm.box = params[:box]
    override.vm.box_url = params[:box_url]
  end

  # Drop the memory requirement to 256 for now.
  # config.vm.provider :web do |web, override|
  #   web.customize ["modifyvm", :id, "--memory", "512"]
  #   override.vm.box = params[:box]
  #   override.vm.box_url = params[:box_url]
  # end

  # Provision i-MSCP
  config.vm.provision 'shell' do |s|
    s.path = Params::PROVISION_DIR + '/configure.sh'
    s.args = Params.build_args
  end
  
  # config.vm.provision "shell", path: "docs/vagrant/scripts/aptupdate.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/setlang.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/installreqs.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/createpreseed.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/install.sh"
  
end

