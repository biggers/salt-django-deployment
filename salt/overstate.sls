database: 
  match: database*,hotfailover*
  sls:
    - postgresql_server
searchservers: 
  match: elastic*
  sls:
    - elasticsearch
pgpoolservers: 
  - match: nodegroup
  - pgpool
cacheservers: 
  match: memcached*
  sls:
    - memcached
rabbitmqservers:
  match: rabbitmq*
  sls:
    - rabbitmqbroker
hotfailover: 
  match: failover*
  sls:
    - postgresql_server.hotfailover
  require:
    - database
celeryworkers: 
  match: celery*
  sls:
    - djangoapp
    - djangoceleryworker
  require:
    - database
    - hotfailover
    - searchservers
    - rabbitmqservers
webservers: 
  match: web*
  sls:
    - djangoapp
    - djangowebserver
  require:
    - database
    - hotfailover
    - searchservers
    - celeryworkers
loadbalancer:
  match: load*
  sls:
    - loadbalancer
  require:
    - webservers
all:
  match: '*'
  require:
    -  database
    -  searchservers
    -  pgpoolservers
    -  cacheservers
    -  rabbitmqservers
    -  hotfailover
    -  celeryworkers
    -  webservers
    -  loadbalancer