# docs.ruby-lang.org

## Platform Environment

* AWS EC2 Tokyo region
* Debian 9(stretch): `apt install nginx groonga git bundler certbot`
* passenger nginx module: https://www.phusionpassenger.com/library/install/nginx/install/oss/stretch/
* We use `capistrano` for deployments.

## Directory structure

* All applications run at `rurema` user.
* rurema-search: `/var/rubydoc`
* docs.ruby-lang.org: `/var/www/docs.ruby-lang.org`
* nginx configuration: `/etc/nginx/sites-available/docs.ruby-lang.org`

## Related project

* https://github.com/ruby/rurema-search
