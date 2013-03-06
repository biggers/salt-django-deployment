include:
  - djangoapp
  - supervisord
  
nginx:                 # ID declaration
  pkg:                  # state declaration
    - installed         # function declaration
  service:
    - running
    - watch:
      - file: /etc/nginx/*
        
/etc/nginx/nginx.conf:
  file:
    - managed
    - source: salt://djangowebserver/nginx.conf
    - template: jinja
    - context:
      nginx_user: "www-data"
    - watch_in:
      - nginx
    - require:
      - service: nginx
        
/etc/nginx/sites-enabled:
  file.directory:
    - makedirs: True
    
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
    - require:
      - virtualenv: django_env
      - pkg: supervisor
    - require:
      - file: {{ pillar['django']['project'] }}/gunicorn.conf.py
            
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
    - require:
      - file: /etc/nginx/nginx.conf