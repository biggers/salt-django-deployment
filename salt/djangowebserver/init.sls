{% set gunicorn_user="vagrant" %}
{% set root="/home/%s" % gunicorn_user %}
{% set virtualenv='%s/django/venv' % root %}
{% set project='%s/django/project' % root %}
{% set ip='127.0.0.1' %}
{% set port='8001' %}

/etc/supervisor/conf.d/{{ gunicorn_user }}_gunicorn.conf:
  file.managed:
    - source: salt://djangowebserver/gunicorn_supervisor.conf
    - template: jinja
    - context:
      virtualenv: {{ virtualenv }}
      project: {{ project }}
      gunicorn_user: {{ gunicorn_user }}
    - watch_in:
      - supervisor
      
{{ project }}/gunicorn.conf.py:
  file.managed:
    - source: salt://djangowebserver/gunicorn.conf.py
    - template: jinja
    - context:
      ip: {{ ip }}
      port: {{ port }}
      log: {{ project }}/gunicorn.log

/etc/nginx/sites-enabled/{{ projectname }}.conf:
  file.managed:
    - source: salt://djangowebserver/site.conf
    - template: jinja
    - context:
      ip: {{ ip }}
      port: {{ port }}
    - watch_in:
      - nginx