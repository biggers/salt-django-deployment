include:
  - postgresql_server.install
  - postgresql_server.config
        
pg_hba.conf_noauth:
  file.managed:
    - source: salt://postgresql_server/pg_hba.conf
    - name: /etc/postgresql/9.1/main/pg_hba.conf
    - user: postgres
    - group: postgres
    - template: jinja
    - watch_in:
      - service: postgresql                               
    - require:
      - pkg: postgresql
    - context:
      no_auth: true

create_cluster:
  cmd.run:
    - name: sleep 10 && pg_dropcluster --stop 9.1 main && pg_createcluster --start -e UTF-8 --locale en_GB.utf8 9.1 main && sleep 10
    - unless: psql -U postgres -c 'show lc_collate;' | grep -q utf8
    - require:
      - file: pg_hba.conf_noauth

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