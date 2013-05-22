# This would go in /etc/salt/master

file_roots:
  base:
    - /srv/salt/base
  dev:
    - /srv/salt/dev
    - /srv/salt/qa
    - /srv/salt/base
  qa:
    - /srv/salt/qa
    - /srv/salt/base