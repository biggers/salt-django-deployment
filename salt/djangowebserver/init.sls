{% set gunicorn_user =  %}
{% set root="/home/%s/django" % pillar['user'] %}
{% set virtualenv='%s/venv' % root %}
{% set project='%s/project' % root %}

/etc/supervisor/conf.d/{{ pillar['user'] }}_gunicorn.conf:
  file.managed:
    - source: salt://djangowebserver/gunicorn_supervisor.conf
    - template: jinja
    - context:
      virtualenv: {{ virtualenv }}
      project: {{ project }}
      gunicorn_user: {{ pillar['user'] }}
    - watch_in:
      - supervisor
      
{{ project }}/gunicorn.conf.py:
  file.managed:
    - source: salt://djangowebserver/gunicorn.conf.py
    - template: jinja
    - context:
      ip: {{ pillar['ip'] }}
      port: {{ pillar['port'] }}
      log: {{ project }}/gunicorn.log

/etc/nginx/sites-enabled/{{ pillar['projectname'] }}.conf:
  file.managed:
    - source: salt://djangowebserver/site.conf
    - template: jinja
    - context:
      ip: {{ pillar['ip'] }}
      port: {{ pillar['port'] }}
    - watch_in:
      - nginx