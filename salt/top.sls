base:
  'dalek1*':
  - match: pcre
  - postgresql_server
  'dalek2*':
  - match: pcre
  - djangowebserver
  - rabbitmqserver

