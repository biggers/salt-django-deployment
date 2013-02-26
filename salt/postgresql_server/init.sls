include:
  - postgresql_server.install
  - postgresql_server.config
  
postgresql.conf:
  extend:
      postgresql.conf:
        - context:
            trust_host: "127.0.0.1"
        - watch_in:
            - service: postgresql                               
        - require:
          - pkg: postgresql
          
pg_hba.conf:
  extend:
    pg_hba.conf:
      - require:
        - file: postgresql.conf
      - watch_in:
        - service: postgresql                   

