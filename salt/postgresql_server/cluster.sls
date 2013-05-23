include:
  - postgresql_server.install
  - postgresql_server.config
  
{% if salt['pillar.get']('cluster_created', default=False) != True %}

postgresql_restart:
  service.restart:
    - name: postgresql
     
pg_hba.conf_noauth:
  file.managed:
    - source: salt://postgresql_server/pg_hba.conf
    - name: /etc/postgresql/9.1/main/pg_hba.conf
    - user: postgres
    - group: postgres
    - template: jinja
    - watch_in:
      - service: postgresql_restart                               
    - require:
      - pkg: postgresql
    - context:
      - no_auth: true

create_cluster:
  cmd.run:
    - name: echo "No cluster, eh?"
#    - name: sleep 10 && pg_dropcluster --stop 9.1 main && pg_createcluster --start -e UTF-8 --locale en_GB.utf8 9.1 main && sleep 10
    - unless: psql -U postgres -c 'show lc_collate;' | grep -q utf8
    - require:
      - file: pg_hba.conf_noauth
      - service: postgresql_restart

extend:
  postgresql.conf:
    file.managed:
      - require:
        - cmd: create_cluster    

extend:
  pg_hba.conf:
    file.managed:
      - require:
        - cmd: create_cluster

cluster_created:
  data.update:
    - True
    - require:
      - cmd: create_cluster  

{% endif %}

