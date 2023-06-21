#!/bin/bash
cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo python3 -m pip install ansible
tee -a playbook.yml > /dev/null <<EOT
- hosts: localhost
  tasks:
    - name: instalando python3, virtualenv
      apt:
        pkg:
        - python3
        - virtualenv
        update_cache: yes
      become: yes
    
    - name: git clone do repositorio
      ansible.builtin.git:
        repo: https://github.com/alura-cursos/clientes-leo-api.git
        dest: /home/ubuntu/clientes-leo-api
        version: master
        force: yes

    - name: instalando dependencias com pip
      pip:
        virtualenv: /home/ubuntu/venv
        requirements: /home/ubuntu/clientes-leo-api/requirements.txt
    
    - name: alterando o hosts do settings
      lineinfile:
        path: /home/ubuntu/clientes-leo-api/setup/settings.py
        regexp: '^ALLOWED_HOSTS'
        line: 'ALLOWED_HOSTS = ["*"]'
        backrefs: yes

    - name: rodando migrations
      shell: '. /home/ubuntu/venv/bin/activate && cd /home/ubuntu/clientes-leo-api && python manage.py migrate'

    - name: carregando os dados iniciais
      shell: '. /home/ubuntu/venv/bin/activate && cd /home/ubuntu/clientes-leo-api && python manage.py loaddata clientes.json'
  
    - name: rodando o servidor
      shell: '. /home/ubuntu/venv/bin/activate && cd /home/ubuntu/clientes-leo-api && nohup python manage.py runserver 0.0.0.0:8000 &'
EOT
ansible-playbook playbook.yml

