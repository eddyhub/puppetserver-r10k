# wget 'https://forgeapi.puppetlabs.com/v3/files/stephenrjohnson-puppet-1.3.1.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-stdlib-4.6.0.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-apt-2.0.1.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-puppetdb-4.2.1.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-inifile-1.2.0.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-postgresql-4.3.0.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-firewall-1.6.0.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-concat-2.0.0.tar.gz'
# wget 'https://forgeapi.puppetlabs.com/v3/files/puppetlabs-apache-1.4.1.tar.gz'

# mv stephenrjohnson-puppet-1.3.1 puppet
# mv puppetlabs-stdlib-4.6.0 stdlib
# mv puppetlabs-puppetdb-4.2.1 puppetdb
# mv puppetlabs-postgresql-4.3.0 postgresql
# mv puppetlabs-inifile-1.2.0 inifile
# mv puppetlabs-firewall-1.6.0 firewal
# mv puppetlabs-concat-2.0.0 concat
# mv puppetlabs-apt-2.0.1 apt
# mv puppetlabs-apache-1.4.1 apache


# git clone git@github.com:puppetlabs/puppetlabs-stdlib.git stdlib
# git clone git@github.com:puppetlabs/puppetlabs-apt.git apt
# git clone git@github.com:puppetlabs/puppetlabs-puppetdb.git puppetdb
# git clone git@github.com:puppetlabs/puppetlabs-inifile.git inifile
# git clone git@github.com:puppetlabs/puppetlabs-postgresql.git
# git clone git@github.com:puppetlabs/puppetlabs-concat.git concat
# git clone git@github.com:puppetlabs/puppetlabs-firewall.git firewall
# git clone git@github.com:puppetlabs/puppetlabs-postgresql.git postgresql
# git clone git@github.com:puppetlabs/puppetlabs-apache.git apache
# git clone git@github.com:puppetlabs/puppetlabs-inifile.git inifile
# git clone git@github.com:stephenrjohnson/puppetmodule.git puppet

# git clone git@github.com:theforeman/puppet-puppet.git puppet
# git clone git@github.com:theforeman/puppet-concat_native.git concat_native
# git clone git@github.com:theforeman/puppet-foreman.git foreman





# r10k needed modules
# git clone git@github.com:puppetlabs/puppetlabs-stdlib.git stdlib
# git clone git@github.com:puppetlabs/puppetlabs-ruby.git ruby
# git clone git@github.com:puppetlabs/puppetlabs-gcc.git gcc
# git clone 'git@github.com:puppetlabs/puppetlabs-inifile.git' inifile
# git clone git@github.com:puppetlabs/puppetlabs-vcsrepo.git vcsrepo
# git clone git@github.com:puppetlabs/puppetlabs-git.git git
# git clone git@github.com:acidprime/r10k.git r10k




# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
VAGRANTFILE_API_VERSION = "2"


puppet_labs_release = <<SCRIPT
if [ ! -f "/etc/apt/sources.list.d/puppetlabs-pc1.list" ]; then
#wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
#dpkg -i puppetlabs-release-trusty.deb
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
dpkg -i puppetlabs-release-pc1-trusty.deb
apt-get update
apt-get remove -y puppet puppet-common
rm -fr /etc/puppet
apt-get autoremove -y
echo PATH="$PATH:/opt/puppetlabs/bin" > /etc/environment
fi
SCRIPT

puppet_agent = <<SCRIPT
if [ ! -d "/opt/puppetlabs" ]; then
apt-get install -y puppet-agent
fi
SCRIPT

puppet_master = <<SCRIPT
if [ ! -d "/opt/puppetlabs" ]; then
apt-get install -y puppetserver
fi
SCRIPT

agent_hosts = <<SCRIPT
if ! grep -q master /etc/hosts; then
echo '192.168.0.10 master master.local' >> /etc/hosts
fi
SCRIPT

# $puppet_labs_release_master = <<SCRIPT
# if [ ! -f puppetlabs-release-trusty.deb ]; then
# #wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
# #dpkg -i puppetlabs-release-trusty.deb
# wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
# dpkg -i puppetlabs-release-pc1-trusty.deb
# apt-get update
# apt-get remove -y puppet puppet-common
# apt-get install -y puppetserver
# echo "127.0.1.1 master.local" >> /etc/hosts
# fi
# SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/trusty64"
    master.vm.hostname = "master"
    master.vm.network "forwarded_port", guest: 443, host:4443
    master.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2560"]
    end
    master.vm.provision "shell", inline: puppet_labs_release
    master.vm.provision "shell", inline: puppet_master
    # master.vm.provision "puppet" do |puppet|
    #   puppet.module_path = "modules"
    # end
    master.vm.network "private_network", ip: "192.168.0.10", adapter: 2
  end
  config.vm.define "agent00" do |agent00|
    agent00.vm.box = "ubuntu/trusty64"
    agent00.vm.hostname = "agent00"
    agent00.vm.network "private_network", ip: "192.168.0.100", adapter: 2
    agent00.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
    agent00.vm.provision "shell", inline: agent_hosts
    agent00.vm.provision "shell", inline: puppet_labs_release
    agent00.vm.provision "shell", inline: puppet_agent
    # agent00.vm.provision "puppet" do |puppet|
    #   puppet.module_path = "modules"
    # end
  end
end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline <<-SHELL
  #   sudo apt-get install apache2
  # SHELL
#end
