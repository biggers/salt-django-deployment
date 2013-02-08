postgresql-install:
  pkg.installed:
    - names:
      - postgresql-8.4
      - postgresql-server-dev-8.4
      - postgresql-client-8.4
      - postgresql-client-common
      - postgresql-common

postgresql.conf:
  file.managed:
    - source: salt://postgresql_server/postgresql.conf
    - name: /etc/postgresql/8.4/main/postgresql.conf
    - user: postgres
    - group: postgres
    - template: jinja
    - context:
        listen_addresses: {{ salt['network.ipaddr']('eth0') }}
        postgres_logging: "off"
        
pg_hba.conf:
  file.managed:
    - source: salt://postgresql_server/pg_hba.conf
    - name: /etc/postgresql/8.4/main/pg_hba.conf
    - user: postgres
    - group: postgres
    - template: jinja
    - context:
        trust_host: "127.0.0.1"
        completetrust: true

main:
  file.directory:
    - name: /etc/postgresql/8.4/main
    - makedirs: True
    - user: postgres
    - group: postgres
    - require:
      - pkg: postgresql-install           
                          
postgresql.conf-beforenewcluster:
  extend:
      postgresql.conf:
        - template: jinja
        - context:
            trust_host: "127.0.0.1"
        - require:
          - file: main
                                 
pg_hba.conf-beforenewcluster:
  extend:
    pg_hba.conf:
      - require:
        - file: postgresql.conf-beforenewcluster
                    
pre_reload_conf:
  cmd.run:
    - name: /etc/init.d/postgresql-8.4 restart
    - require:
      - file: pg_hba.conf-beforenewcluster
            
create_cluster:
  cmd.run:
    - name: pg_dropcluster --stop 8.4 main && LANG=en_GB.utf8 pg_createcluster --start -e UTF-8 8.4 main
    - unless: psql -U postgres -c 'show lc_collate;' | grep -q utf8
    - require:
      - cmd: pre_reload_conf

pg_log:
  file.directory:
    - name: /var/lib/postgresql/8.4/main/pg_log
    - makedirs: True
    - user: postgres
    - group: postgres
    - require:
      - cmd: create_cluster
                      
postgresql.conf-afternewcluster:
  extend:
      postgresql.conf:
        - require:
          - file: pg_log
        - watch_in:
            - service: postgresql-8.4-running
               
pg_hba.conf-afternewcluster:
  extend:
    pg_hba.conf:      
      - require:
        - file: postgresql.conf-afternewcluster
      
post_reload_conf:
  cmd.run:
    - name: /etc/init.d/postgresql-8.4 restart
    - require:
      - file: pg_hba.conf-afternewcluster
                    
postgresql-8.4-running:
  service:
    - name: postgresql-8.4
    - running
    - require:
      - cmd: post_reload_conf
