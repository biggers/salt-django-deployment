{% set user = "django" %}
{% set projectname = "test" %}
{% set root = '/home/%s/django' % user %}
django:
  virtualenv: {{ root }}/venv
  project: {{ root }}/project/{{ projectname }}
  user: {{ user }}
  ip: "127.0.0.1"
  port: 8000
  projectname: myproject
  servername: 127.0.0.1