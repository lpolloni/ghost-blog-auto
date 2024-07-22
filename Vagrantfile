Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  config.vm.network "private_network", type: "dhcp"
  config.vm.network "public_network", bridge: "wlp0s20f3"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "debian"
    vb.memory = "2048"
    vb.cpus = 4
  end

  config.vm.hostname = "debian"
  config.vm.synced_folder "./data", "/data"

  config.vm.provision "shell", inline: <<-SHELL
    echo "[TASK $((++count))] Initial configuration"
    apt update >/dev/null 2>&1
    apt upgrade -y >/dev/null 2>&1
    apt install -y git htop tmux vim >/dev/null 2>&1 
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
  SHELL

  config.vm.provision "shell", path: "./scripts/provision.sh"

end