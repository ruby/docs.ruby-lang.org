# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'debian/stretch64'

  docs_https_port = ENV.fetch('DOCS_HTTPS_PORT') { 10443 }.to_i
  config.vm.network 'forwarded_port', guest: 443, host: docs_https_port

  config.vm.provision 'ansible' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.playbook = 'provision/playbook.yml'
    ansible.extra_vars = {
      docs_https_port: docs_https_port,
    }
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.playbook = 'provision/selfsigned.yml'
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.playbook = 'provision/rurema-search.yml'
  end
end
