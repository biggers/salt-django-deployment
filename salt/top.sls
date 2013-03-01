base:
  'um1*':
  - match: pcre
  - loadbalancer
  'um2*':
  - match: pcre
  - djangoapp
  - djangowebserver
  'database*':
  - match: pcre
  - postgresql_server
  'um3*':
  - match: pcre
  - postgresql_server.hotfailover
  'um4*':
  - match: pcre
  - elasticsearch
  'um5*':
  - match: pcre
  - djangoapp
  - djangoceleryworker
  'um6*':
  - match: pcre
  - rabbitmqbroker
  'um7*':
  - match: pcre
  - pgpool
  'um8*':
  - match: pcre
  - memcached