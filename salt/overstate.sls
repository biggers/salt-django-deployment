database: 
  match: dalek1*
  sls:
    - postgresql_server
# searchserver: 
#   match: search*
#   sls:
#     - elasticsearch
# cacheserver: 
#   match: memcached*
#   sls:
#     - memcached
rabbitmqserver:
  match: dalek1*
  sls:
    - rabbitmqbroker
# hotfailover: 
#   match: failover*
#   sls:
#     - postgresql_server.hotfailover
#   require:
#     - database
# pgpoolserver: 
#   match: pgpool*
#   sls:
#     - pgpool
#   require:
#     - database
#     - hotfailover
celeryworker: 
  match: dalek1*
  sls:
    - djangoapp
    - djangoceleryworker
  require:
    - database
# - hotfailover
# - searchserver
    - rabbitmqserver
webservers: 
  match: dalek2*
  sls:
    - djangoapp
    - djangowebserver
  require:
    - database
# - hotfailover
# - searchserver
    - celeryworker
# loadbalancer:
#   match: load*
#   sls:
#     - loadbalancer
#   require:
#     - webservers
all:
  match: '*'
  require:
    -  database
#    -  searchserver
#    -  pgpoolserver
#    -  cacheserver
    -  rabbitmqserver
#    -  hotfailover
    -  celeryworker
    -  webservers
#    -  loadbalancer
