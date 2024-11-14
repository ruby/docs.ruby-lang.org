# Contributing

## How docs.ruby-lang.org/en Works

### Overview

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
