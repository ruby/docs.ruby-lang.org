# Contributing

## How docs.ruby-lang.org/en Works

The English Ruby documentation is automatically generated and updated through a pipeline involving GitHub Actions, AWS S3, and systemd services. Here's how it all comes together:

1. **Documentation Generation and Upload**

   - A scheduled [GitHub Action](https://github.com/ruby/actions/blob/master/.github/workflows/docs.yml) generates the documentation for all [actively maintained Ruby versions](https://www.ruby-lang.org/en/downloads/branches/) plus the master branch. Each documentation set is generated using the version of RDoc bundled with that specific Ruby version.
     - *Example:* For [Ruby 3.3](https://docs.ruby-lang.org/en/3.3/), the documentation is generated with RDoc 6.6.3.1.
   - The generated docs are uploaded as `ruby-docs-en-<version>.tar.xz` to the `ftp.r-l.o/pub/ruby/doc/` S3 bucket.
     - You can find these uploads at [cache.ruby-lang.org/pub/ruby/doc/](https://cache.ruby.org/pub/ruby/doc/), which is powered by [cache.r-l.o](https://github.com/ruby/cache.r-l.o).

2. **Website Update**

   - On the server running this application, the `update-docs-en.timer` systemd timer triggers the `rdoc-static-all` service at scheduled intervals.
     - Timer definition: [update-docs-en.timer](https://github.com/ruby/docs.ruby-lang.org/blob/master/provision/systemd/update-docs-en.timer)
     - Service definition: [rdoc-static-all.service](https://github.com/ruby/docs.ruby-lang.org/blob/master/provision/systemd/rdoc-static-all.service)
   - The `rdoc-static-all` service runs the [rdoc-static-all](https://github.com/ruby/docs.ruby-lang.org/blob/master/system/rdoc-static-all) script.
     - This script downloads the latest documentation from S3 and updates the website accordingly.

## How docs.ruby-lang.org/ja Works

The Japanese Ruby documentation (Rurema) is automatically generated and updated through a pipeline involving GitHub repositories, systemd services, and BitClust tool. Here's how it all comes together:

1. **Documentation Generation and Upload**

   - The Japanese documentation is generated from the [rurema/doctree](https://github.com/rurema/doctree) repository, which contains the source documents for the Rurema project.
   - Pre-generated documentation databases and HTML files are maintained in the [rurema/generated-documents](https://github.com/rurema/generated-documents) repository.

2. **Website Update**

   - On the server running this application, the `update-docs-ja.timer` systemd timer triggers the `bc-setup-all` service at scheduled intervals (daily at 20:15).
     - Timer definition: [update-docs-ja.timer](https://github.com/ruby/docs.ruby-lang.org/blob/master/provision/systemd/update-docs-ja.timer)
     - Service definition: [bc-setup-all.service](https://github.com/ruby/docs.ruby-lang.org/blob/master/provision/systemd/bc-setup-all.service)
   - The `bc-setup-all` service runs the [bc-setup-all](https://github.com/ruby/docs.ruby-lang.org/blob/master/system/bc-setup-all) script.
     - This script updates the local repositories (bitclust, doctree, and generated-documents) and links the pre-generated documentation databases.

3. **Static HTML Generation**

   - When the `bc-setup-all` script completes, it triggers the `bc-static-all.path` systemd path unit by updating a timestamp file.
     - Path definition: [bc-static-all.path](https://github.com/ruby/docs.ruby-lang.org/blob/master/provision/systemd/bc-static-all.path)
   - The path unit triggers the `bc-static-all.service`, which runs the [bc-static-all](https://github.com/ruby/docs.ruby-lang.org/blob/master/system/bc-static-all) script.
     - Service definition: [bc-static-all.service](https://github.com/ruby/docs.ruby-lang.org/blob/master/provision/systemd/bc-static-all.service)
   - The `bc-static-all` script:
     - Syncs pre-generated HTML files from the `generated-documents` repository to the web server directory
     - Creates symbolic links for `latest` and `master` versions
     - Purges the Fastly cache for updated content
