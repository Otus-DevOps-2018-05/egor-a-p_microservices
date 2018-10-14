# egor-a-p_microservices
egor-a-p microservices repository

  ## Домашнее задание 12
 
 Что сделано:
 
  - образ на основе запущенного контейнера из образа ubuntu с дополнительно созданным файлом /tmp/file и /bin/bash в качестве init-процесса

 Задание со *:
 
  - проведено сравнение описаний образа и контейнера
  
  ## Домашнее задание 13
 
 Что сделано:
 
  - создан новый проект GCP с именем docker, установлена docker-machine, создан docker-host в GCE
  - повторение практики из лекции по работе с PID, network и user namespaces
  - создан образ с reddit и залит в docker hub

 Задание со *:
 
  - сборка образа пакером из docker-monolith/infra: packer build -var-file=packer/variables.json packer/docker.json
  
