require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))

configValues = YAML.load_file("#{dir}/config.yaml")
data = configValues['vagrantfile-local']



Vagrant.configure("2") do |config|
  config.vm.box     = "#{data['vm']['box']}"
  config.vm.box_url = "#{data['vm']['box_url']}"

  config.vm.network "private_network", ip:  "#{data['vm']['server_ip']}"

  config.vm.synced_folder "#{dir}", "/vagrant"
  data['vm']['synced_folder'].each do |i, folder|
    if folder['source'] != '' && folder['target'] != '' && folder['id'] != ''
      nfs    = (folder['nfs'] == "true") ? "nfs" : nil
      create = (folder['create'] == "true") ? true : false
      owner  = (folder['owner'] != '') ? folder['owner'] : "root"
      group  = (folder['group'] != '') ? folder['owner'] : "root"
      config.vm.synced_folder "#{folder['source']}", "#{folder['target']}", 
                              create: create,
                              owner: owner, 
                              group: group
    end
  end

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ['modifyvm', :id, '--memory', "#{data['vm']['memory']}"]
  end
  
  # config.vm.provider :webserver do |vb|
  #   vb.gui = false
  #   vb.customize ['modifyvm', :id, '--memory', "#{data['vm']['memory']}"]
  # end

  data['vm']['provision'].each do |i, provision|   
    type  = (provision['type'] != '') ? provision['type'] : "shell"
    if !provision['args'].nil? 
      args = provision['args'].join(' ')
      config.vm.provision "#{type}" do |s|
        s.path = "#{provision['path']}"
        s.args = "#{args}"
      end
    else
      config.vm.provision :shell, :path => "#{provision['path']}"
    end
  end


#  config.vm.provision :shell, :path => "#{dir}/provision/service-stop.sh"
  
#  config.vm.provision :shell, :path => "#{dir}/provision/service-start.sh"


  if !data['ssh']['host'].nil?
    config.ssh.host = "#{data['ssh']['host']}"
  end
  if !data['ssh']['port'].nil?
    config.ssh.port = "#{data['ssh']['port']}"
  end
  if !data['ssh']['private_key_path'].nil?
    config.ssh.private_key_path = "#{data['ssh']['private_key_path']}"
  end
  if !data['ssh']['username'].nil?
    config.ssh.username = "#{data['ssh']['username']}"
  end
  if !data['ssh']['guest_port'].nil?
    config.ssh.guest_port = data['ssh']['guest_port']
  end
  if !data['ssh']['shell'].nil?
    config.ssh.shell = "#{data['ssh']['shell']}"
  end
  if !data['ssh']['keep_alive'].nil?
    config.ssh.keep_alive = data['ssh']['keep_alive']
  end
  if !data['ssh']['forward_agent'].nil?
    config.ssh.forward_agent = data['ssh']['forward_agent']
  end
  if !data['ssh']['forward_x11'].nil?
    config.ssh.forward_x11 = data['ssh']['forward_x11']
  end
  if !data['vagrant']['host'].nil?
    config.vagrant.host = data['vagrant']['host'].gsub(":", "").intern
  end
end

