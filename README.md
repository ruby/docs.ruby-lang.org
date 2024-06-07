# docs.ruby-lang.org

## WARNING

* This repository is inconsistent with production.
* Use only `bundle exec cap production deploy`. Do not use `ansible-playbook`.

## Platform Environment

* We use `capistrano` for deployments.
* Currently hosted on AWS EC2 Tokyo region
  * All applications run as `rurema` user.
* Periodic tasks run in systemd timer (`systemctl list-timers`)

## Files and Directories

* rurema-search: `/var/rubydoc`
* docs.ruby-lang.org: `/var/www/docs.ruby-lang.org`
* nginx configuration: `/etc/nginx/sites-available/docs.ruby-lang.org`

## Files need to backup

* old statically generated contents (old versions need to copy from old server): `/var/www/docs.ruby-lang.org/shared/public/{en,ja}/*`
  * Versioned contents of `ja` are from <https://github.com/rurema/generated-documents> since 2024-06-06.
* Fastly API Key: `/home/rurema/.docs-fastly`
* Slack webhook URL: `/etc/systemd/system/notify-to-slack.env`
* Mackerel API Key and plugin configurations: `/etc/mackerel-agent/mackerel-agent.conf`

## Related repos

* https://github.com/ruby/rurema-search
* https://github.com/rurema/generated-documents

## Production Environment

## Capstrano

```
cap production deploy
```

### /etc/mackerel-agent/mackerel-agent.conf

Install `mackerel-check-plugins` too.

Add/Modified:

```
[filesystems]
ignore = "/dev/loop*"

[plugin.checks.fileage-bc-setup-all]
command = ["check-file-age", "-i", "-w", "90000", "-c", "172800", "-f", "/run/docs.ruby-lang.org/bc-setup-all.updated"]
[plugin.checks.fileage-bc-static-all]
command = ["check-file-age", "-i", "-w", "90000", "-c", "172800", "-f", "/run/docs.ruby-lang.org/bc-static-all.updated"]
[plugin.checks.fileage-rdoc-static-all]
command = ["check-file-age", "-i", "-w", "90000", "-c", "172800", "-f", "/run/docs.ruby-lang.org/rdoc-static-all.updated"]
[plugin.checks.fileage-update-rurema-index]
command = ["check-file-age", "-i", "-w", "90000", "-c", "172800", "-f", "/run/docs.ruby-lang.org/update-rurema-index.updated"]
```
