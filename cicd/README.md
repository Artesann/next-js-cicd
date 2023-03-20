## Ansible
# Как развернуть jenkins на существующую машину
1. В дирректории ansible загрузить зависимости `ansible-galaxy install -r requirements.yaml`
2. Ip машины записать в inventory.ini
3. `ansible-playbook -i inventory.ini -vD run.yml`