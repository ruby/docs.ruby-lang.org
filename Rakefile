require 'rdoc/task'

versions = {
  "trunk" => "trunk",
  "2.2.0" => "ruby_2_2",
  "2.1.0" => "ruby_2_1",
  "2.0.0" => "ruby_2_0_0",
  "1.9.3" => "ruby_1_9_3",
  "1.8.7" => "ruby_1_8_7",
}

versions.each do |version, branch_name|
  source_dir = "sources/#{version}"

  directory source_dir do
    sh "git clone --depth=1 --branch=#{branch_name} git://github.com/ruby/ruby.git #{source_dir}"
  end

  desc "Checks out source for #{version}"
  task "source:#{version}" => source_dir

  desc "Updates source for #{version}"
  task "update:#{version}" => source_dir do
    Dir.chdir source_dir do
      sh "git pull origin #{branch_name}"
    end
  end

  namespace :rdoc do
    lang_version = File.join("en", version)
    RDoc::Task.new(lang_version) do |rdoc|
      rdoc.title = "Documentation for Ruby #{version}"
      rdoc.main = "README"
      rdoc.rdoc_dir = version
      rdoc.rdoc_files << source_dir
      rdoc.options << "-U"
      rdoc.options << "--all"
      rdoc.options << "--root=#{source_dir}"
      rdoc.options << "--page-dir=#{source_dir}/doc"
      rdoc.options << "--encoding=UTF-8"
    end
  end
  task "rdoc:#{version}" => "update:#{version}"
end

desc "Checks out sources for all versions"
task "source" => versions.keys.map { |version| "source:#{version}" }

desc "Updates sources for all versions"
task "update" => versions.keys.map { |version| "update:#{version}" }

desc "Build RDoc HTML files for all versions"
task "rdoc" => versions.keys.map { |version| "rdoc:#{version}" }

