base:
  'web*':
  - match: pcre
  - djangowebserver
  'database*':
  - match: pcre
  - postgresql_server