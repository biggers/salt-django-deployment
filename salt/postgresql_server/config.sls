postgresql.conf:
  file.managed:
    - source: salt://postgresql_server/postgresql.conf
    - name: /etc/postgresql/8.4/main/postgresql.conf
    - user: postgres
    - group: postgres
    - template: jinja
        
pg_hba.conf:
  file.managed:
    - source: salt://postgresql_server/pg_hba.conf
    - name: /etc/postgresql/8.4/main/pg_hba.conf
    - user: postgres
    - group: postgres
    - template: jinja