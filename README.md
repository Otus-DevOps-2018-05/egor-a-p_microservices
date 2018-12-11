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

  ## Домашнее задание 15
 
 Что сделано:
 
  - добавлен docker-compose.yml
  - в docker-compose.yml изменен под две сети
  - docker-compose.yml параметризирован (порт публикации сервиса ui, версии сервисов, volume для монго)
  - добавлены .env и .env.example файлы
  - все создаваемые docker-compose сущности имеют одинаковый префикс src, префикс может быть изменен опцией -p либо переменной COMPOSE_PROJECT_NAME

 Задание со *:
  - чтобы изменять код каждого из приложений, не выполняя сборку образа в docker-compose.override.yml монтируются volume-ы с исходниками приложения в контейнеры
  ```
      APP_PATH=/home/docker-user/src
  
      ${APP_PATH}/ui:/app
      ${APP_PATH}/post-py:/app
      ${APP_PATH}/comment:/app
      
      docker-machine scp -r ui docker-host:~/src/
      docker-machine scp -r post-py docker-host:~/src/
      docker-machine scp -r comment docker-host:~/src/
  ```
  - в docker-compose.override.yml добавлен запуск puma для руби приложений в дебаг режиме с двумя воркерами

  ## Домашнее задание 16
 
 Что сделано:
 
  - подготовлен хост с докером. гитлабом и раннерами
  - добавлен пайплайн
  - добавлен тест к приложению

 Задание со *:
  - докер-хост, гитлаб и раннеры можно разворачивать из /gitlab-ci/terraform/ci
  - добавлены уведомления в Slack #egor_petrov

  ## Домашнее задание 17
 
 Что сделано:
 
  - добавлены окружения dev, stage и prod
  - добавлены динамические окружения

 Задание со *:
  - при пуше новой ветки должен создается виртуалка для окружения с возможностью удалить его кнопкой
  - в шаге build собирается образ reddit и пушится в docker hub
  - образ reddit деплоится при пуше ветки

  ## Домашнее задание 18
  
 Config:
 ```
   gcloud compute firewall-rules create prometheus-default --allow tcp:9090  
   gcloud compute firewall-rules create puma-default --allow tcp:9292
   export GOOGLE_PROJECT=
   
   docker-machine create --driver google \
       --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts \
       --google-machine-type n1-standard-1 \
       --google-zone europe-north1-c \
       docker-host
   
   eval $(docker-machine env docker-host)
   docker run --rm -p 9090:9090 -d --name prometheus  prom/prometheus
 ```
 
 Что сделано:
 
  - Prometheus: запуск и конфигурация
  - Мониторинг состояния микросервисов
  - Сбор метрик хоста с использованием node экспортера

 Задание со *:
  - мониторинг MongoDB
  - мониторинг сервисов comment, post, ui с помощью blackbox экспортера
  - Makefile для создания хоста, сборки образов и деплоя

  ## Домашнее задание 19

 Что сделано:
 
  - Метрики сервисов в grafana
  - Метрики бизнес-логики в grafana
  - Алертинг, нотификация в слак

  ## Домашнее задание 20

 Что сделано:
 
- Cоздан отдельный compose-файл для логгирования
- Создан образ контейнера с fluentd
- Обновленны контейнеры с Reddit.
- Добалена конфигурация fluentd для работы со сруктурированными и не структрурированными логами.
