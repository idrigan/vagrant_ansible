
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  config.vm.box = "nrel/CentOS-6.7-x86_64"
  
  config.vm.synced_folder "./ansible", "/ansible"


  config.vm.define "web", primary: true do |web|
      web.vm.network :private_network, ip: "192.168.33.50"
      web.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
      web.vm.network :forwarded_port, guest: 443, host: 8081, auto_correct: true

      web.vm.hostname = "ansibleMpwar"

      web.vm.provision :shell, path: "shell/vagrant_main_provision.sh"
    end

end
