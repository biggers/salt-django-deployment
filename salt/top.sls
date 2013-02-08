base:
    loadbalancers:
        - match: nodegroup
        - loadbalancer
    webservers: 
        - match: nodegroup
        - djangoapp
        - djangowebserver
    databases: 
        - match: nodegroup
        - postgresql_server
    hotfailover: 
        - match: nodegroup
        - postgresql_server.hotfailover
    searchservers: 
        - match: nodegroup
        - elasticsearch
    celeryworkers: 
        - match: nodegroup
        - djangoapp
        - djangoceleryworker
    rabbitmqservers:
        - match: nodegroup
        - rabbitmqbroker
    pgpoolservers: 
        - match: nodegroup
        - pgpool
    cacheservers: 
        - match: nodegroup
        - memcached