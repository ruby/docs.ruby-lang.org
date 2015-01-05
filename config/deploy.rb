set :application, 'docs.ruby-lang.org'
set :repo_url, 'git@github.com:ruby/docs.ruby-lang.org.git'
set :deploy_to, '/var/www/docs.ruby-lang.org'
set :linked_dirs, %w{sources en/1.8.7 en/1.9.3 en/2.0.0 en/2.1.0 en/2.2.0 en/trunk ja/1.8.7 ja/1.9.3 ja/2.0.0 ja/2.1.0 ja/2.2.0}

set :rbenv_type, :user
set :rbenv_ruby, '2.1.5'
