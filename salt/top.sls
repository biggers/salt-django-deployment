base:
    loadbalancers:
        - match: nodegroup
        - loadbalancer
    webservers: 
        - match: nodegroup
        - webserver
    databaseservers: 
        - match: nodegroup
        - database
    searchservers: 
        - match: nodegroup
        - elasticsearch
    celeryworkers: 
        - match: nodegroup
        - celeryd
    rabbitmqservers 
        - match: nodegroup
        - rabbitmq
    pgpoolservers: 
        - match: nodegroup
        - pgpool
    cacheservers: 
        - match: nodegroup
        - memcached