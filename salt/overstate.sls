database: 
  match: database*
  sls:
    - postgresql_server
searchserver: 
  match: search*
  sls:
    - elasticsearch
cacheserver: 
  match: memcached*
  sls:
    - memcached
rabbitmqserver:
  match: rabbitmq*
  sls:
    - rabbitmqbroker
hotfailover: 
  match: failover*
  sls:
    - postgresql_server.hotfailover
  require:
    - database
pgpoolserver: 
  match: pgpool*
  sls:
    - pgpool
  require:
    - database
    - hotfailover
celeryworker: 
  match: celery*
  sls:
    - djangoapp
    - djangoceleryworker
  require:
    - database
    - hotfailover
    - searchserver
    - rabbitmqserver
webservers: 
  match: web*
  sls:
    - djangoapp
    - djangowebserver
  require:
    - database
    - hotfailover
    - searchserver
    - celeryworker
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
    -  searchserver
    -  pgpoolserver
    -  cacheserver
    -  rabbitmqserver
    -  hotfailover
    -  celeryworker
    -  webservers
    -  loadbalancer