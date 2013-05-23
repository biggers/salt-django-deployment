django_packages:
  pkg.installed:
    - names:
      - python-pip
      - python-dev
      - git-core
      - libpq-dev
      - build-essential
      
virtualenv:      
   pip.installed:
     - require:
       - pkg: django_packages

{{ pillar['django']['user'] }}:
  user.present:
    - home: /var/{{ pillar['django']['user'] }}
    - shell: /bin/bash
    
{{ pillar['django']['virtualenv'] }}:
  file.directory:
    - user: {{ pillar['django']['user'] }}
    - makedirs: True
    - mode: 755
        
django_env:
  virtualenv.managed:
    - name: {{ pillar['django']['virtualenv'] }}
    - no_site_packages: False
    - system_site_packages: True
    - distribute: True
    - requirements: salt://djangoapp/requirements.txt
    - runas: {{ pillar['django']['user'] }}
    - activate: True
    - upgrade: True
    - require:
      - pip: virtualenv
      - user: {{ pillar['django']['user'] }}
      - file: {{ pillar['django']['virtualenv'] }}