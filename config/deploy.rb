set :application, 'docs.ruby-lang.org'
set :repo_url, 'https://github.com/ruby/docs.ruby-lang.org'
set :deploy_to, '/var/www/docs.ruby-lang.org'

set :default_env, {
  'PATH' => '/snap/bin:$PATH',
  'DEBIAN_DISABLE_RUBYGEMS_INTEGRATION' => 'true',
}
versions = %w[
  1.8.7 1.9.3
  2.0.0 2.1.0 2.2.0 2.3.0 2.4.0 2.5.0 2.6.0 2.7.0
  3.0 3.1 3.2
  master
]
set :linked_dirs, ["sources", "public/ja/latest"] + versions.map{|v| ["public/en/#{v}", "public/ja/#{v}"]}.flatten
