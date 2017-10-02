# docs.ruby-lang.org

## Platform Environment

* We use `capistrano` for deployments.
* Currently hosted on AWS EC2 Tokyo region
  * All applications run as `rurema` user.
* Periodic tasks run in cron (`crontab -u rurema`)

### Requisites

* Debian 9 (stretch)
  * `apt install nginx groonga git bundler certbot`
* passenger nginx module: https://www.phusionpassenger.com/library/install/nginx/install/oss/stretch/

## Files and Directories

* rurema-search: `/var/rubydoc`
* docs.ruby-lang.org: `/var/www/docs.ruby-lang.org`
* nginx configuration: `/etc/nginx/sites-available/docs.ruby-lang.org`

## Related repos

* https://github.com/ruby/rurema-search
