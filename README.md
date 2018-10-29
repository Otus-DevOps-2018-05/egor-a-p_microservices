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
 
  - плейбук для накатывания докера на ubuntu (использовал роль angstwad.docker_ubuntu)
  - сборка образа пакером из docker-monolith/infra: packer build -var-file=packer/variables.json packer/docker.json
  - развертывание инстансов с докером с помощью terraform
  - роль для запуска контейнера с reddit
  
  ## Домашнее задание 14
 
 Что сделано:
 
  - написаны докерфайлы для микросервисов, созданные образы задеплоены
  - оптимизирован образ ui
  - добавлен volume к контейнеру с монго, контейнер с монго перезапущен, пост на месте


 Задание со *:
  - Запущены контейнеры с другими сетевыми алиасами, при запуске контейнеров заданы переменные окружения соответствующие новым сетевым алиасам:
  ```
     docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
     docker run -d --network=reddit --network-alias=comment_host egorapetrov/comment:1.0
     docker run -d --network=reddit --network-alias=post_host egorapetrov/post:1.0
     docker run -d --network=reddit -p 9292:9292 --env POST_SERVICE_HOST=post_host --env COMMENT_SERVICE_HOST=comment_host  egorapetrov/ui:1.0
  ```
  - Образы ui и comment собраны на ruby-alpine, в итоге вышло:
  ```
     REPOSITORY            TAG        SIZE
     egorapetrov/ui        3.0        241MB
     egorapetrov/comment   2.0        231MB
     egorapetrov/ui        2.0        461MB
     egorapetrov/comment   1.0        771MB
     egorapetrov/ui        1.0        779MB
     egorapetrov/post      1.0        102MB

  ```
