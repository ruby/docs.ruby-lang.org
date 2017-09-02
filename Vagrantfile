# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"
  config.vm.provision "shell", inline: <<-SHELL
    apt update -y
    apt upgrade -y
    # for setup
    apt install -y nginx git bundler apt-transport-https ca-certificates curl lv
    # for convenience
    apt install -y lv w3m

    dpkg -l groonga > /dev/null 2>&1 || (
      echo "deb https://packages.groonga.org/debian/ stretch main" > /etc/apt/sources.list.d/groonga.list &&
      apt update -y;
      apt install -y --allow-unauthenticated groonga-keyring &&
      apt update -y &&
      apt install -y -V groonga
    )

    dpkg -l libnginx-mod-http-passenger > /dev/null 2>&1 || (
     apt install -y dirmngr gnupg &&
     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 &&
     echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger stretch main" > /etc/apt/sources.list.d/passenger.list &&
     apt-get update -y &&
     apt install -y libnginx-mod-http-passenger
    )

    grep rurema /etc/passwd > /dev/null 2>&1 || (
      useradd -m -s /bin/bash rurema &&
      usermod -aG sudo rurema &&
      cp -a /home/vagrant/.ssh /home/rurema/.ssh &&
      chown -R rurema:rurema /home/rurema/.ssh
    )

    mkdir -p /var/www/docs.ruby-lang.org /var/rubydoc
    chown -R rurema:rurema /var/www/docs.ruby-lang.org /var/rubydoc

    echo "20 13 * * * cd /var/www/docs.ruby-lang.org/current; ruby system/rdoc-static-all
15  0 * * * cd /var/www/docs.ruby-lang.org/current; ruby system/bc-setup-all; ruby system/bc-static-all
15  2 * * * cd /var/www/docs.ruby-lang.org/current; system/update-rurema-index" > /tmp/crontab.rurema
    crontab -u rurema /tmp/crontab.rurema

    ls /var/rubydoc/doctree > /dev/null 2>&1 ||
      su - rurema -c "sh -c 'cd /var/rubydoc/ && git clone https://github.com/rurema/doctree.git'"

    ls /etc/nginx/sites-available/docs.ruby-lang.org > /dev/null 2>&1 ||
      curl --silent -o /etc/nginx/sites-available/docs.ruby-lang.org https://raw.githubusercontent.com/ruby/docs.ruby-lang.org/master/conf/docs.ruby-lang.org
      ln -s ../sites-available/docs.ruby-lang.org /etc/nginx/sites-enabled/docs.ruby-lang.org
      rm /etc/nginx/sites-enabled/default

    echo "prepare done: exec cap deploy"
  SHELL
end
