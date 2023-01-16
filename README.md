## Стек Vector/Clickhouse/Lighthouse на Yandex Cloud
Задачей этого проекта является организация транспорта данных из файла (например логи), которые
мы собираем с помощью Vector и передаем в СУБД clickhouse и 
вывод результата в графиках с помощью lighthouse.

В ```/terrafrom/main.tf``` описана инфраструктура из 3-ех виртуальных машин (на centos7): 
lighthouse-1, clickhouse-1, vector-1.
Разворачиваем эти машины на yandex cloud.
В дальнейшем ip адреса этих машин мы вносим в соответствующие поля ```/inventory/prod.yml```.
С помощью ansible мы установим на созданную инфраструктуру стек vector/clickhouse/lighthouse.

Важно! Для работы lighthouse нам так же потребуется установить web server nginx.

### Playbook ansible состоит из:

1. group_vars: в ```clickhouse.yml``` прописана версия clickhouse и какие именно пакеты 
нужно установить (server, client, common-static). Тоже самое для lighthouse в ```lighthouse.yml```.
В ```vector.yml``` мы указываем откуда брать данные (/home/centos/logs/*.log) и 
куда транслировать (clickhouse).
2. Inventory файл содержит в себе информацию о хостах на которых мы будем запускать наш playbook.
3. После установки приложений, нам нужно будет изменить их настройки. Мы автоматизируем этот процесс
с помощью директории /templates. Там размещаем файлы конфигов, которые нужно перезаписать на 
развернутых в облаке машинах.
Меняем доступ clickhouse с localhost на любой другой ```<listen_host>0.0.0.0</listen_host>```.
В nginx прописываем пользователя. Vector и lighthouse задаем стандартные параметры.
4. Таски описаны в ```site.yml```. Они скачивают rpm пакеты clickhouse, vector, lighthouse, nginx
и устанавливают их на хостах. Затем применяют к ним конфиги из /templates.

