include:
  - postgresql_server.install

postgresql.conf:
  file.managed:
    - source: salt://postgresql_server/postgresql.conf
    - name: /etc/postgresql/8.4/main/postgresql.conf
    - user: postgres
    - group: postgres
    - template: jinja
    - watch_in:
      - service: postgresql                               
    - require:
      - pkg: postgresql
	- context:
      - trust_host: "127.0.0.1"
        
pg_hba.conf:
  file.managed:
    - source: salt://postgresql_server/pg_hba.conf
    - name: /etc/postgresql/8.4/main/pg_hba.conf
    - user: postgres
    - group: postgres
    - template: jinja
    - watch_in:
      - service: postgresql                               
    - require:
      - pkg: postgresql