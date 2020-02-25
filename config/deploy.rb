set :application, 'docs.ruby-lang.org'
set :repo_url, 'https://github.com/ruby/docs.ruby-lang.org'
set :deploy_to, '/var/www/docs.ruby-lang.org'

set :default_env, {
  'PATH' => '/snap/bin:$PATH',
}
# TODO: Add 3.0.0 after 2.8.0 is changed to 3.0.0
versions = %w[1.8.7 1.9.3 2.0.0 2.1.0 2.2.0 2.3.0 2.4.0 2.5.0 2.6.0 2.7.0 master]
set :linked_dirs, ["sources", "public/ja/latest"] + versions.map{|v| ["public/en/#{v}", "public/ja/#{v}"]}.flatten
