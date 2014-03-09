require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

configValues = YAML.load_file("#{dir}/puphpet/config.yaml")
data = configValues['vagrantfile-local']

Vagrant.configure("2") do |config|
  config.vm.box = "#{data['vm']['box']}"
  config.vm.box_url = "#{data['vm']['box_url']}"

  config.vm.synced_folder params[:www_dir], '/var/www',
                          create: true, owner: 'www-data', group: 'www-data'
  
  data['vm']['synced_folder'].each do |i, folder|
    if folder['source'] != '' && folder['target'] != '' && folder['id'] != ''
      nfs = (folder['nfs'] == "true") ? "nfs" : nil
      config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{folder['id']}", type: nfs
    end
  end

  if !data['vm']['provider']['virtualbox'].empty?
    config.vm.provider :virtualbox do |virtualbox|
      virtualbox.gui = false
      data['vm']['provider']['virtualbox']['modifyvm'].each do |key, value|
        if key == "natdnshostresolver1"
          value = value ? "on" : "off"
        end
        virtualbox.customize ["modifyvm", :id, "--#{key}", "#{value}"]
      end
    end
  end  

  config.vm.provision "shell" do |s|
    s.path = "puphpet/shell/initial-setup.sh"
    s.args = "/vagrant/puphpet"
  end
  config.vm.provision :shell, :path => "puphpet/shell/update-puppet.sh"
  config.vm.provision :shell, :path => "puphpet/shell/librarian-puppet-vagrant.sh"

  config.vm.provision :puppet do |puppet|
    ssh_username = !data['ssh']['username'].nil? ? data['ssh']['username'] : "vagrant"
    puppet.facter = {
      "ssh_username" => "#{ssh_username}"
    }
    puppet.manifests_path = "#{data['vm']['provision']['puppet']['manifests_path']}"
    puppet.manifest_file = "#{data['vm']['provision']['puppet']['manifest_file']}"

    if !data['vm']['provision']['puppet']['options'].empty?
      puppet.options = data['vm']['provision']['puppet']['options']
    end
  end

  config.vm.provision :shell, :path => "puphpet/shell/execute-files.sh"


  # config.vm.synced_folder '../VirtualBoxVMs', '/VirtualBoxVMs',
  #                         create: true, owner: 'vagrant', group: 'vagrant'

  # config.vm.provider :virtualbox do |vb, override|
  #   vb.gui = false
  #   vb.customize ['modifyvm', :id, '--memory', params[:memory]]
  #   override.vm.box = params[:box]
  #   # override.vm.box_url = params[:box_url]
  # end

  # Drop the memory requirement to 256 for now.
  # config.vm.provider :web do |web, override|
  #   web.customize ["modifyvm", :id, "--memory", "512"]
  #   override.vm.box = params[:box]
  #   override.vm.box_url = params[:box_url]
  # end

  # Provision i-MSCP
  # config.vm.provision "shell", path: "docs/vagrant/scripts/aptupdate.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/setlang.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/installreqs.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/createpreseed.sh"
  # config.vm.provision "shell", path: "docs/vagrant/scripts/install.sh"


  # config.vm.provision 'shell' do |s|
  #   s.path = Params::PROVISION_DIR + '/configure.sh'
  #   s.args = Params.build_args
  # end

  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "provision/manifests"
  #   puppet.manifest_file  = "site.pp"
  #   puppet.module_path = "provision/modules"

  #   puppet.facter = {
  #     "hostip" => `ifconfig vboxnet0 | grep inet | awk '{print $2}'`
  #   }
  # end
  
end

