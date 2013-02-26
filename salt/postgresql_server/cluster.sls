include:
  - postgresql_server.install
  - postgresql_server.config
  
pg_hba.conf_noauth:
  extend:
    pg_hba.conf:
      - require:
        - pkg: postgresql
          
create_cluster:
  cmd.run:
    - name: sleep 10 && pg_dropcluster --stop 8.4 main && LANG=en_GB.utf8 pg_createcluster --start -e UTF-8 8.4 main
    - unless: psql -U postgres -c 'show lc_collate;' | grep -q utf8
    - require:
      - file: pg_hba.conf_noauth

postgresql.conf:
  extend:
    postgresql.conf:
      - require:
        - cmd: create_cluster
        
pg_hba.conf_auth:
  extend:
    pg_hba.conf:
      - require:
        - file: postgresql.conf