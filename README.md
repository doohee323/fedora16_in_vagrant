fedora16_in_vagrant
=====================================

Make vagrant vm for Fedora-16

https://cbednarski.com/articles/veewee/

1. requirements
	curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled
	gem update
	gem install net-scp

2. install veewee
	gem install veewee
	git clone https://github.com/jedi4ever/veewee.git
	cd veewee

3. make a veewee vbox
	https://github.com/jedi4ever/veewee/tree/master/templates
	veewee vbox define fedora-server_16_64 Fedora-16-x86_64

4. change url in definition.rb
	cf. /Users/dhong/tmp/veewee/templates/Fedora-16-x86_64-netboot/definition.rb
	
	:iso_file => "Fedora-16-i686-Live-KDE.iso",
	:iso_src => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/16/Live/i686/Fedora-16-i686-Live-KDE.iso",

5. build vbox
	veewee vbox build fedora-server_16_64 -n
	
	ll ~/VirtualBox VMs/

6. export to vagrant
	need to shutdown virtualbox of Fedora-16-x86_64
	veewee vbox export fedora-server_16_64

7. add vagrant
	vagrant box add 'fedora-server_16_64' '/Users/dhong/tmp/veewee/fedora-server_16_64.box'

8. install something in fedora
	cd /etc/yum.repos.d
	change all 'https' to 'http' in each *.repo file"
	
	baseurl=http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/16/Everything/x86_64/os/
