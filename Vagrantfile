require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

configValues = YAML.load_file("#{dir}/config.yaml")
data = configValues['vagrantfile-local']



Vagrant.configure("2") do |config|
  config.vm.box     = "#{data['vm']['box']}"
  config.vm.box_url = "#{data['vm']['box_url']}"

  config.vm.network "private_network", ip:  "#{data['vm']['server_ip']}"


  data['vm']['synced_folder'].each do |i, folder|
    if folder[:source] != '' && folder[:target] != '' && folder[:id] != ''
      nfs    = (folder['nfs'] == "true") ? "nfs" : nil
      create = (folder['create'] == "true") ? true : false
      owner  = (folder['owner'] != '') ? folder['owner'] : "root"
      group  = (folder['group'] != '') ? folder['owner'] : "root"
      config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", id: "#{folder['id']}",
                              type: nfs, create: create,
                              owner: owner, group: group
    end
  end

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ['modifyvm', :id, '--memory', "#{data['vm']['memory']}"]
  end

  data['vm']['provision'].each do |i, provision|   
    args = provision['args'].join(' ')
    type  = (provision['type'] != '') ? provision['type'] : "shell"
    config.vm.provision "#{type}" do |s|
      s.path = "#{provision['path']}"
      s.args = "#{args}"
    end
  end
end

