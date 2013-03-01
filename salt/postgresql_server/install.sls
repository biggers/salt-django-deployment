postgresql:
  pkg.installed:
    - names:
      - postgresql
      - postgresql-client-common
      - libpq-dev
  service.restart:
    - name: postgresql