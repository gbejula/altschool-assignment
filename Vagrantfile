Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.cpus = "2"
  end

  # Master setup
  config.vm.define "master" do |subconfig|
    subconfig.vm.box = "ubuntu/focal64"
    subconfig.vm.hostname = "master"
    subconfig.vm.network :private_network, ip: "192.168.20.5"
  end

  # Slave setup
  config.vm.define "slave" do |subconfig|
    subconfig.vm.box = "ubuntu/focal64"
    subconfig.vm.hostname = "slave"
    subconfig.vm.network :private_network, ip: "192.168.20.6"
  end

  # Provisioning script
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get -y install net-tools
  SHELL

  # DNS service for interaction
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install -y avahi-daemon libnss-mdns
  SHELL
  
  # Install all the following softwares
  config.vm.provision "shell", inline: <<-SHELL
    echo -e "\n\n\n\Updating Apt Packages, upgrading latest patches and installing the softwares\n\n\n\n"
    sudo apt update
    sudo apt -y upgrade
    sudo apt install -y apache2
    sudo apt -y install software-properties-common
    sudo apt install php libapache2-mod-php -y
    sudo apt install mysql-server -y
    sudo systemctl start mysql.service
    sudo systemctl restart apache2
    sudo systemctl status apache2
    sudo apt install sshpass -y
  SHELL
end
