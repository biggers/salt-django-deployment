include:
  - djangoapp
  - supervisor
  - nginx

/etc/supervisor/conf.d/{{ pillar['django']['user'] }}_gunicorn.conf:
  file.managed:
    - source: salt://djangowebserver/gunicorn_supervisor.conf
    - template: jinja
    - context:
      virtualenv: {{ pillar['django']['virtualenv'] }}
      project: {{ pillar['django']['project'] }}
      user: {{ pillar['django']['user'] }}
    - watch_in:
      - supervisor
      
{{ pillar['django']['project'] }}/gunicorn.conf.py:
  file.managed:
    - source: salt://djangowebserver/gunicorn.conf.py
    - template: jinja
    - context:
      ip: {{ pillar['django']['ip'] }}
      port: {{ pillar['django']['port'] }}
      log: {{ pillar['django']['project'] }}/gunicorn.log

/etc/nginx/sites-enabled/{{ pillar['django']['projectname'] }}.conf:
  file.managed:
    - source: salt://djangowebserver/site.conf
    - template: jinja
    - context:
      ip: {{ pillar['django']['ip'] }}
      port: {{ pillar['django']['port'] }}
      servername: {{ pillar['django']['servername'] }}
    - watch_in:
      - nginx