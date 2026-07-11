set :application, 'docs.ruby-lang.org'
set :repo_url, 'https://github.com/ruby/docs.ruby-lang.org'
set :deploy_to, '/var/www/docs.ruby-lang.org'

set :default_env, {
  'PATH' => '/snap/bin:$PATH',
  'DEBIAN_DISABLE_RUBYGEMS_INTEGRATION' => 'true',
}
ja_versions = %w[
  1.8.7 1.9.3
  2.0.0 2.1.0 2.2.0 2.3.0 2.4.0 2.5.0 2.6.0 2.7.0
  3.0 3.1 3.2 3.3 3.4
  4.0
  master
]
# /en/ の 1.8.7 と 1.9.3 は配信できる中身がない（英語版ドキュメントの
# アーカイブは 2.0.0 以降のみ）ため linked_dirs に含めない
en_versions = ja_versions - %w[1.8.7 1.9.3]
master_version = '4.1'
set :linked_dirs, ["sources", "public/ja/#{master_version}", "public/ja/latest", "public/ja/search"] + en_versions.map{|v| "public/en/#{v}"} + ja_versions.map{|v| "public/ja/#{v}"}
