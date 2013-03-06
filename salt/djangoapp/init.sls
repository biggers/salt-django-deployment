{% set root="/home/%s/django" % pillar['user'] %}
{% set virtualenv='%s/venv' % root %}
{% set project='%s/project/%s' % (root, pillar['projectname']) %}
