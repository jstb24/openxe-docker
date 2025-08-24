# openxe-docker
OpenXE Dockerinstallation

https://openxe.org/

Diese Konfiguration basiert auf ein php:8.3-apache-bullseye Image und enthält bereits die erforderlichen php Module
und den Cronjob für OpenXE

Es geht mit einem Alpineimage deutlich schlanker. Sobald ich Zeit habe, werde ich ein weiteres Setup aufsetzen mit Alpinebasis



## Getting started

Kopiere env Template und ändere Credentials für Mariadb

~~~
cp env.template .env \
nano .env
~~~


Starte Installationsscript

~~~
./install.sh
~~~

Nach dem Buildprozess und Containerstart zur Einrichtung von OpenXE auf http://<deine-server-ip>:8081

!!! Für Produktivumgebungen unbedingt hinter einem z.B. NGINX Reverseproxy betreiben !!!


