postgresql:
  pkg.installed:
    - names:
      - postgresql-8.4
      - postgresql-server-dev-8.4
      - postgresql-client-8.4
      - postgresql-client-common
      - postgresql-common
                    
postgresql:
  service:
    - name: postgresql-8.4
    - running
    - require:
      - pkg: postgresql_installed