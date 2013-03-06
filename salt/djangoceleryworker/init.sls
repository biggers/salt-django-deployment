include:
  - djangoapp
  - supervisor

/etc/supervisor/conf.d/{{ pillar['user'] }}_celery.conf:
  file.managed:
    - source: salt://djangoceleryworker/celery_supervisor.conf
    - template: jinja
    - context:
      virtualenv: {{ virtualenv }}
      project: {{ project }}
      user: {{ pillar['user'] }}
    - watch_in:
      - supervisor
