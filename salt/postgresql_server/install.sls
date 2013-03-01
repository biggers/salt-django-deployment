postgresql:
  pkg.installed:
    - names:
      - postgresql-8.4
      - postgresql-server-dev-8.4
      - postgresql-client-8.4
      - postgresql-client-common
      - postgresql-common
  service.running:
    - name: postgresql-8.4
    - require:
      - pkg: postgresql_installed