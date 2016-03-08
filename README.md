Make vagrant vm for Fedora-16
=====================================

-. requirements
```
	curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled
	gem update
	gem install net-scp
```
-. install veewee
```
	gem install veewee
	git clone https://github.com/jedi4ever/veewee.git
	cd veewee
```

-. make a veewee vbox
```
	https://github.com/jedi4ever/veewee/tree/master/templates
	veewee vbox define fedora-server_16_64 Fedora-16-x86_64
```

-. change url in definition.rb
```
	cf. /Users/dhong/veewee/templates/Fedora-16-x86_64-netboot/definition.rb
	
	:iso_file => "Fedora-16-i686-Live-KDE.iso",
	:iso_src => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/16/Live/i686/Fedora-16-i686-Live-KDE.iso",
```

-. build vbox
```
	veewee vbox build fedora-server_16_64 -n
	
	ll ~/VirtualBox VMs/
```

-. export to vagrant
```
	need to shutdown virtualbox of Fedora-16-x86_64
	veewee vbox export fedora-server_16_64
```

-. add vagrant
```
	vagrant box add 'fedora-server_16_64' '/Users/dhong/veewee/fedora-server_16_64.box'
```

-. run vagrant
```
	cd fedora16_in_vagrant
	vagrant init 'fedora-server_16_64'
	vagrant up
	vagrant ssh
```

-. install something in fedora
```
	cd /etc/yum.repos.d
	change all 'https' to 'http' in each *.repo file"
	
	baseurl=http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/16/Everything/x86_64/os/
	
	yum -y update
```

-. /usr/sbin/biosdevname: No such file or directory error fix
```
	vi /opt/vagrant/embedded/gems/gems/vagrant-1.7.2/plugins/guests/fedora/cap/configure_networks.rb
	/usr/sbin/biosdevname => /sbin/biosdevname
```

cf. https://cbednarski.com/articles/veewee/

	