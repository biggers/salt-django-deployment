{% set user = "django" %}
{% set projectname = "myproj" %}
{% set root = '/var/django' %}
django:
  virtualenv: {{ root }}
  project: {{ root }}/{{ projectname }}
  user: {{ user }}
  group: {{ user }}
  ip: "127.0.0.1"
  port: 8080
  projectname: {{ projectname }}
  servername: 127.0.0.1

